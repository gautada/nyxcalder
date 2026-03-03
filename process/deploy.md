# deploy

Read, understand, and apply the
[merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Integrated'` and
`assignee = 'Blair Fontaine'` or
`assignee = 'blairfontaine'`. Exclude any items
that have a `stalled` label — those belong to Adam
and must not be touched.

## Stalled Check

Before processing any items, also check for items
you have previously commented on that carry a
`clarification` or `criteria` label and are
assigned to `gautada`. For each such item:

- If the most recent activity (comment, label change,
  or assignment change) is more than 2 hours old:
  apply a `stalled` label to the item. Leave
  existing labels and `assignee = gautada`
  unchanged. Do not comment.
- If the most recent activity is within 2 hours:
  skip — Adam is working on it.

## Process (For each item)

- **Review** the item and all comments in full.
  - If clarification is needed: post a comment with
    your specific question(s). Apply the
    `clarification` label. Set `assignee = gautada`.
    Skip to the next item. Adam will remove the
    label and reassign to you when resolved.

- **Review Acceptance Criteria** — verify that all
  acceptance criteria have been checked off. Nyx
  checks off `[Develop]` criteria during self-review;
  Dev checks off `[Integrate]` criteria during the
  build. Every criterion should be accounted for.
  - If any criterion is unchecked, or if comments
    contain conflicting information about whether a
    criterion was met:
    - If the item does **not** already have a
      `criteria` label: post a comment describing
      exactly which criteria are unmet or
      conflicting and why. Apply the `criteria`
      label. Set `assignee = gautada`. Skip to the
      next item.
    - If the item **already has** a `criteria`
      label: set `assignee = gautada`. Skip to the
      next item. Do not post a duplicate comment.
  - `[Run]` criteria are verified by Ren in the
    live environment and are not required to be
    checked off before deploy.

- **Create Release PR** — create a PR from `dev` →
  `main` per the
  [merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md).
  Include `References #N` in the PR body. Do NOT
  use `Closes #N`. PR title must be the version
  identifier (e.g. `v2026.3.2`).

- **Add a comment** to the item with a link to the
  release PR.

- **Merge the PR** and confirm the merge.

- **Create version tag** — after merge, create a
  version tag on `main` matching the PR title.

- **Watch Action** — monitor the GitHub Action
  triggered by the merge until it reaches a terminal
  state.
  - If the Action **fails**: document the failure
    details in a comment. Apply a `failure` label.
    Set `assignee = gautada`. Stop processing this
    item. Adam will remove the label and reassign
    when resolved.

- **Write Release Notes** — add a comment to the
  item covering:
  - What was released and what changed
  - A summary of each acceptance criterion and how
    it was satisfied
  - Any known limitations or follow-on items
  - The version tag associated with this release

- **Close the item** — set `status = 'Done'` and
  set `assignee = moiravoss`.
