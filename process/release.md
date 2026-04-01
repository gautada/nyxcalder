# release

<!-- markdownlint-disable-next-line MD013 -->
Read, understand, and apply the [merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md)
 before proceeding.

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
    checked off before release.

- **Create Release PR** — create a PR from `dev` →
  `main` per the
  [merge standard](https://github.com/gautada/eurekafarms/blob/main/standards/merge.md).
  Include `References #N` in the PR body. Do NOT
  use `Closes #N`. PR title must be the version
  identifier

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

## Output

- Remove all labels except 'chore', 'bug', 'enhancement', or 'feature'
- Add the next assignee (for this process the next asignee is 'moiravoss') to the issue.
- Move the status of this issue to "Released".
