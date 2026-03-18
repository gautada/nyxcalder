# plan

<!-- markdownlint-disable-next-line MD013 -->
Read, understand, and apply the [merge](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md)
standards before proceeding.

## Input

You should have aleardy run the fetch-input tool. This process is for each issue
in the list.

## Process

- Remove all other assignees but yourself.
- Read and fully understand the issue gathered for input.
- Collect internal references (like the repository and README.md)
- Check and load your latest memory regarding this repository

## Process (For each item)

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
  - If multiple `cicd-*` topics exist: this is a
    configuration error. Post a comment documenting
    which conflicting topics were found. Apply a
    `failure` label. Set `assignee = gautada`. Skip
    to the next item.

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

## Output

- Remove all labels except 'chore', 'bug', 'enhancement', or 'feature'
- Add the next assignee (for this process the next asignee is 'blairfontaine') to the issue.
- Move the status of this issue to "Integrated".
