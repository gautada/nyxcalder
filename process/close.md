# review

Read, understand, and apply the
[review standard](https://github.com/gautada/eurekafarms/blob/main/standards/review.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Done'` and
`assignee = 'Moira Voss'` or
`assignee = 'moiravoss'`. Exclude any items that
have a `stalled` label.

## Process (For each item)

- **Confirm pickup** — before doing anything else,
  remove all assignees from the item except yourself
  (`moiravoss`). This confirms you have taken
  ownership and clears any previous-stage assignees
  left over from the handoff.

- **Fetch the full timeline** — retrieve the
  complete history of the item: all status
  transitions, label additions and removals,
  assignee changes, comments, and linked PRs.
  Reconstruct the item's path through the pipeline
  from creation to Done.

- **Score the item** per the
  [review standard](https://github.com/gautada/eurekafarms/blob/main/standards/review.md).
  Compute the numeric score and letter grade. Build
  a narrative summary of findings: what went well,
  what created friction, and what drove deductions.

- **Post score comment** — add a comment to the item
  in the format defined by the review standard.
  This is the final comment on the item.

- **Notify Adam** — post the full score comment
  text directly to Adam via Slack so he sees it
  without having to open the issue.

- **Close the issue** — close the GitHub issue.
  Do not archive the project item. Leave it in
  `status = 'Done'` on the board. A GitHub workflow
  will handle archiving automatically after 3 days.
