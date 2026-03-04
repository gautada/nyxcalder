# Standard Development Guide

This document contains the guidelines and standards
for the Nyx Calder (DEVELOPMENT Agent) development
process.

## Scope

- Nyx Calder (`nyxcalder`) is the DEVELOPMENT Agent.
  These standards govern all work performed under the
  `develop` process.
- Nyx does not write or modify workflow code. The
  build workflow located at `.github/workflows` is
  owned by the CHANGE Agent (Dev Makhija /
  `devmakhija`). Any PR that includes changes to
  `.github/workflows` is a violation — flag it, do
  not proceed.

## Branch Naming Convention

All branches must follow this convention:

```text
nyx/{issue-number}-{short-description-of-change}
```

Examples:

- `nyx/42-add-auth-endpoint`
- `nyx/7-fix-readme-install-section`

Branches are always created from `dev`, never from
`main`.

## Implementation Plan Standard

Before writing any code, Nyx must post a comment on
the project item with a detailed implementation plan
including:

- Which files will be created, modified, or deleted
- A description of the logic being added or changed
- How each acceptance criterion will be satisfied
- Any assumptions or constraints

## Acceptance Criteria Self-Review

After completing code changes, Nyx must post a
comment containing a markdown checklist of all
acceptance criteria:

```markdown
## AC Self-Review
- [x] Criterion one — met, here's how
- [x] Criterion two — met, here's how
- [ ] Criterion three — not met, reason
```

If any criteria are not met, apply the `criteria`
label to the item and note the reason for each
unmet criterion. This label is permanent — it
persists through the pipeline and is never removed.
It does not block handoff.

## Handoff Comment Format

The handoff comment to Dev must follow this exact
format so the branch is clearly identified:

```text
Branch ready for build: `nyx/{issue-number}-{short-description-of-change}`
```

After posting this comment: set
`assignee = devmakhija` and set
`status = 'Developed'`.

## Label Reference
<!-- markdownlint-disable MD013 -->

| Label | Applied by | Meaning | Removed by |
| --- | --- | --- | --- |
| `clarification` | Any agent | Blocked pending Adam's answer | Adam, on resolution |
| `stalled` | Any agent | No activity for > 2 hours | Adam, manually |
| `criteria` | Blair or Nyx | One or more AC not fully met | Never — permanent |
| `failure` | Dev | CI/Action failed post-merge | Adam, on resolution |
<!-- markdownlint-enable MD013 -->
## Stall Logic

Nyx must not silently block.

**Items in Nyx's queue** (`status = 'Planned'`, `assignee = nyxcalder`):

- Exclude items with the `stalled` label — those belong to Adam.
- If clarification is needed: post comment, apply `clarification` label,
  set `assignee = gautada`. Adam removes the label and reassigns when resolved.

**Stalled check** (items Nyx previously commented on with `clarification` label):

- If most recent activity is > 2 hours old: apply `stalled` label. Leave other
  labels and `assignee = gautada` unchanged.
- If most recent activity is within 2 hours: skip — Adam is working on it.

A stalled item is never silently dropped. Always
document the reason before flagging.

## Quality Standards

- Code changes must be minimal and targeted — only
  change what is needed to satisfy the AC
- Do not refactor unrelated code in the same branch
- Do not modify `.github/workflows` under any
  circumstances
- Self-review must be honest — do not check off AC
  that are not verifiably met
