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

## Handoff Comment Format

The handoff comment to Adam must follow this exact
format so the branch is clearly identified:

```text
Branch ready for review: `nyx/{issue-number}-{short-description-of-change}`
```

After posting this comment: set
`assignee = gautada`, set `status = 'Developed'`.

Adam reviews the work and — when satisfied —
reassigns to `devmakhija` to trigger integration.

## Stall Logic

Nyx must not silently block. The following
conditions require a stall:

| Condition | Action |
| --- | --- |
| Question still unanswered | Post comment, stall |
| Blocker or unachievable AC | Post comment, stall |
| AC not fully met | Self-review comment, stall |

A stalled item is never silently dropped. Always
document the reason.

## Quality Standards

- Code changes must be minimal and targeted — only
  change what is needed to satisfy the AC
- Do not refactor unrelated code in the same branch
- Do not modify `.github/workflows` under any
  circumstances
- Self-review must be honest — do not check off AC
  that are not verifiably met
