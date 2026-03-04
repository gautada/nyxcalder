# integrate

Read, understand, and apply the
[merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Developed'` and
`assignee = 'Dev Makhija'` or
`assignee = 'devmakhija'`. Exclude any items that
have a `stalled` label — those belong to Adam and
must not be touched.

## Stalled Check

Before processing any items, also check for items
you have previously commented on that carry a
`clarification` or `failure` label and are assigned
to `gautada`. For each such item:

- If the most recent activity (comment, label change,
  or assignment change) is more than 2 hours old:
  apply a `stalled` label to the item. Leave
  existing labels and `assignee = gautada`
  unchanged. Do not comment.
- If the most recent activity is within 2 hours:
  skip — Adam is working on it.

## Process (For each item)

- **Confirm pickup** — before doing anything else,
  remove all assignees from the item except yourself
  (`devmakhija`). This confirms you have taken
  ownership and clears any previous-stage assignees
  left over from the handoff.

- **Review** the item and all comments in full.
  - If clarification is needed: post a comment with
    your specific question(s). Apply the
    `clarification` label. Set `assignee = gautada`.
    Skip to the next item. Adam will remove the
    label and reassign to you when resolved.

- **Find Branch** — locate the handoff comment from
  Nyx (`nyxcalder`) in the format:

  ```text
  Branch ready for review: `nyx/{issue-number}-{short-description-of-change}`
  ```

  - If no branch name comment from Nyx can be found:
    post a comment noting the missing branch
    information. Apply the `clarification` label.
    Set `assignee = gautada`. Skip to the next item.

- **Quality Check** — as the CHANGE Agent, you own
  the workflow code at `.github/workflows`. Nyx must
  not modify workflow files.
  - If the branch contains changes to
    `.github/workflows`: document the violation in a
    comment. Apply the `clarification` label. Set
    `assignee = gautada`. Skip to the next item.

- **Sync CI/CD Workflow** — check the topics of the
  item's repository.
  - For each topic that begins with `cicd-`, extract
    the suffix (e.g. topic `cicd-container` →
    suffix `container`).
  - Fetch the source file from the `gautada/cicd`
    repository at the path
    `templates/cicd/{suffix}.yaml`.
  - Compare it byte-for-byte against the destination
    file `.github/workflows/cicd.yaml` in the item's
    repository on the **default branch** (`main`).
  - If the files differ (or the destination does not
    exist): copy the source file to
    `.github/workflows/cicd.yaml` in the item's
    repository, commit directly to the **feature
    branch** that Nyx prepared, and note the change
    in a comment on the item.
  - If the files already match: no action needed.
  - If the repository has no `cicd-*` topics: skip
    this step entirely.
  - If multiple `cicd-*` topics exist: apply each
    one in turn, using the last suffix found as the
    authoritative source for `cicd.yaml` (topics are
    processed in alphabetical order).

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
  state.
  - If the Action **fails**: document the failure
    details in a comment. Apply a `failure` label.
    Set `assignee = gautada`. Stop processing this
    item. Adam will remove the label and reassign
    when resolved.

- **Document Build** — add a comment detailing the
  Action result. Note anything noteworthy for review.

- **Hand off to Blair** — on successful Action
  completion, add `blairfontaine` as an assignee.
  Do not remove yourself. Set `status = 'Integrated'`.
  Do not remove the `criteria` label if applied.
