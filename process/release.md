# release

Read, understand, and apply the
[criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Integrated'` and
`assignee = 'Blair Fontaine'` or
`assignee = 'blairfontaine'`. Skip any items where
you authored the last comment.

## Process (For each item)

- **Review** the item and all comments in full,
  including the acceptance criteria and all build
  documentation from Dev.
  - If anything is unclear before proceeding: post a
    comment with your specific question(s), skip to
    the next item.
  - If a clarifying question you posted in a previous
    cycle remains unanswered: set
    `assignee = gautada`, set `status = 'Stalled'`,
    post a comment noting the question is still
    pending, skip to next item.

- **Review Acceptance Criteria** — verify that all
  acceptance criteria are checked off in the item's
  comments. If any criteria are unmet or unchecked:
  - Post a comment identifying the unmet criteria
    and the gap.
  - Set `assignee = gautada`, set
    `status = 'Stalled'`, skip to next item.

- **Create Release PR** — create a PR from
  `dev` → `main`. In the PR body, reference the
  issue with `References #N` (do not use `Closes` —
  status will be managed manually). PR title should
  clearly indicate this is a release
  (e.g. `Release: {brief description}`).

- **Add a comment** to the item with a link to the
  release PR.

- **Merge the PR** and confirm the merge.

- **Monitor Action** — monitor the resulting GitHub
  Action launched from the merge until completion.
  - If the Action **fails**: document the failure
    details in a new comment, set
    `assignee = gautada`, set `status = 'Stalled'`,
    stop processing this item.

- **Write Release Notes** — add a detailed release
  comment to the item covering:
  - What was released and what changed
  - A summary of each acceptance criterion and how
    it was satisfied
  - Any known limitations or follow-on items
  - The version or tag associated with this release
    (if applicable)

- **Close the item** — remove all assignees from the
  item and set `status = 'Done'`.
