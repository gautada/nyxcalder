# integrate

Read, understand, and apply the
[merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Developed'` and
`assignee = 'Dev Makhija'` or
`assignee = 'devmakhija'`. Skip any items where you
authored the last comment.

## Process (For each item)

- **Review** the item and all comments in full.
  - If the item already has a `clarification` label:
    - If no new comment from someone other than you exists since your last question:
      - If your last question was posted more than 2 hours ago: remove the `clarification` label, add a `stalled` label, set `assignee = gautada`, skip to the next item.
      - Otherwise: skip this item without commenting.
    - If your question has been answered: remove the `clarification` label and continue processing.
  - If clarification is needed: post a comment with
    your specific question(s). Apply the `clarification`
    label. Remove any existing assignees and set
    `assignee = gautada`. Skip to the next item.

- **Find Branch** — locate the handoff comment from
  Nyx (`nyxcalder`) in the format:

  ```text
  Branch ready for review: `nyx/{issue-number}-{short-description-of-change}`
  ```

  - If no branch name comment from Nyx can be found:
    post a comment noting the missing branch
    information, apply the `clarification` label,
    remove any existing assignees, set
    `assignee = gautada`, skip to the next item.

- **Quality Check** — as the CHANGE Agent, you own
  the workflow code at `.github/workflows`. Nyx must
  not modify workflow files.
  - If the branch contains changes to `.github/workflows`:
    document the violation in a comment, apply the
    `clarification` label, remove any existing
    assignees, set `assignee = gautada`, skip to
    the next item.

- **Create PR** — create a PR from `{branch}` →
  `dev` per the
  [merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md).
  Include `References #N` in the PR body (where `N`
  is the issue number). Do NOT use `Closes #N`.

- **Add a comment** to the item with a link to the PR.

- **Merge Pull Request** and confirm the merge.

- **Delete Branch** — after merge is confirmed,
  delete the feature branch (`{branch}`) from the
  repository.

- **Watch Action** — monitor the GitHub Action
  triggered by the merge until it reaches a terminal
  state (success or failure).
  - If the Action **fails**: document the failure
    details in a comment. Remove the `clarification`
    label if applied. Apply a `failure` label. Set
    `assignee = gautada`. Stop processing this item.

- **Document Build** — add a comment detailing the
  Action result. Note anything noteworthy for review.

- **Hand off to Blair** — on successful Action
  completion, remove the `clarification` label if
  applied, remove the `failure` label if applied.
  Set `assignee = blairfontaine` and set
  `status = 'Integrated'`. Do not remove the
  `criteria` label if applied.
