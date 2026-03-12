---
name: idea-planning
description: |
  Blair-only skill. Do not activate if you are not Blair (blairfontaine).
  Facilitate an idea planning conversation in Slack DMs when a GitHub issue
  under the gautada GitHub organization (gautada/*) with the label 'idea' is
  mentioned. Reads the issue and repo README, then engages in a back-and-forth
  DM conversation to probe, shape, and refine the idea. Captures fully-formed
  ideas as comments on the issue mid-conversation. Writes a summary when the
  conversation goes quiet (5 min), shifts topic, or a new session begins. Use
  when Blair receives a DM mentioning a gautada/* GitHub issue carrying the
  'idea' label. An idea is a not-yet-fully-formed feature or use case for the
  repository.
---

# Idea Planning

## Model

Use `anthropic/claude-sonnet-4-6` (alias: `sonnet`) for this skill.

## Purpose

Turn a rough GitHub idea issue into something concrete through DM
conversation. The conversation is the medium; the issue is the record.

## Trigger Detection

Activate only when you are Blair (blairfontaine). If another agent receives
this message, do not activate this skill.

Activate when a Slack DM references a GitHub issue in the `gautada` organization
(e.g. `#42` with repo context, a URL like `github.com/gautada/REPO/issues/N`, or
`gautada/REPO#N`) and that issue carries the label `idea`. Verify the label
via `gh issue view`.

If the issue is not under `gautada/*` or does not have the `idea` label, do
not activate.

## Session Startup

On the first message of a session:

1. **Fetch the issue** —

```
gh issue view NUMBER --repo gautada/REPO --json title,body,labels,url
```

1. **Fetch the README** —

```
gh api repos/gautada/REPO/contents/README.md --jq '.content' | base64 -d
```

1. **Read both** — understand the stated idea and the repo's purpose and context
2. **Open with substance** — do not say "I've read it." Respond with your
   initial read of the idea: what it's trying to solve, what's interesting
   about it, and your first probing question. Ask only one question at a time.

## Conversation Loop

Each turn:

- **Generate** — formulate thoughts on the idea based on the issue, README,
  and conversation so far
- **Probe** — ask one leading, clarifying, or probing question to deepen the idea:
  - Who benefits from this?
  - What does "done" look like?
  - What's the simplest version of this?
  - What breaks if we don't do this?
  - How does this relate to something in the README?
- **Listen** — incorporate the answer before moving to the next angle
- **Capture mid-conversation** — when an idea sub-thread feels complete and
  well-defined, post it as a comment to the issue immediately (see Comment
  Format below). Continue the conversation. Multiple comments per session is
  expected and fine.

## When to Write a Full Comment

Post a new issue comment when **any** of the following:

- A distinct, well-defined idea has emerged that will not be refined further this turn
- Adam says something like "capture that" / "write that up" / "that's it"
- The conversation has shifted to a new sub-idea and the previous one is settled

Use `gh issue comment NUMBER --repo gautada/REPO --body "BODY"`

### Comment Format

```markdown
## Idea: [short title]

**What:** one sentence describing what this is

**Why:** one sentence — the problem it solves or value it adds

**Shape:**
- bullet points describing the idea's form
- not a spec, just enough to act on

**Open questions:**
- anything still unresolved

_Captured during planning conversation — DATE_
```

## Session End Conditions

End the active session and write a summary comment when **any** of these occur:

1. **5-minute silence** — set a cron job at session start (cron tool, 5 min,
   systemEvent). Reset it (remove and recreate) on every user message. When it
   fires, proceed to summary.
2. **Topic shift** — you detect the conversation has moved to something
   unrelated to this issue
3. **Explicit close** — Adam says something like "done", "that's all",
   "let's move on", "new topic"

### Summary Comment Format

Post one final comment to the issue:

```markdown
## Planning Session Summary — DATE

**Ideas captured this session:** N (see comments above)

**Threads not fully resolved:**
- brief note on any idea that came up but was not fleshed out

**Suggested next questions:**
- questions worth returning to
```

If nothing was left unresolved, keep the summary brief: "Session complete. N
ideas captured."

## Cron Timeout Setup

At session start, schedule the 5-minute inactivity timeout using the cron tool:

- Schedule: every 5 minutes
- Payload: systemEvent with text "IDEA_SESSION_TIMEOUT issue=NUMBER repo=gautada/REPO"

On each user message: remove the existing cron job and recreate it to reset the clock.
On session end (any trigger): remove the cron job.

When IDEA_SESSION_TIMEOUT fires: write the summary comment and remove the job.

## Constraints

- One question per response — do not stack questions
- Do not summarize back what Adam said — build on it
- Do not write a comment until an idea is genuinely defined enough to act on
- Repo context stays in scope for the whole session; do not re-fetch unless
  the issue or repo changes
