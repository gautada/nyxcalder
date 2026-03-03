# plan

Read, understand, and apply the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md) before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Inbox'` and
`assignee = 'Blair Fontaine'` or
`assignee = 'blairfontaine'`. Exclude any items
that have a `stalled` label — those belong to Adam
and must not be touched.

## Stalled Check

Before processing any items, also check for items
you have previously commented on that carry a
`clarification` label and are assigned to
`gautada`. For each such item:

- If the most recent activity (comment, label change,
  or assignment change) is more than 2 hours old:
  apply a `stalled` label to the item. Leave the
  `clarification` label and `assignee = gautada`
  unchanged. Do not comment.
- If the most recent activity is within 2 hours:
  skip — Adam is working on it.

## Process (For each item)

- **Confirm pickup** — before doing anything else,
  remove all assignees from the item except yourself
  (`blairfontaine`). This confirms you have taken
  ownership and clears any previous-stage assignees
  left over from the handoff.

- **Review** the item and all comments in full.
  - If clarification is needed: post a comment with
    your specific question(s). Apply the
    `clarification` label. Set `assignee = gautada`.
    Skip to the next item. Adam will remove the
    label and reassign to you when resolved.

- **Write acceptance criteria** — post a single
  comment containing a list of all acceptance
  criteria per the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md).
  - If any criteria cannot be made fully testable:
    apply a `criteria` label and note which criteria
    are affected in the AC comment. This label
    persists through the pipeline and is never
    removed.

- **Hand off to Nyx** — once all clarifying
  questions are resolved and acceptance criteria are
  written, add `nyxcalder` as an assignee. Do not
  remove yourself. Then set `status = 'Planned'`.
