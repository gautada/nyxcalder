# develop

Read, understand, and apply the
[develop standard](https://github.com/gautada/eurekafarms/blob/main/standards/develop.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Planned'` and
`assignee = 'Nyx Calder'` or
`assignee = 'nyxcalder'`. Exclude any items that
have a `stalled` label — those belong to Adam and
must not be touched.

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
  (`nyxcalder`). This confirms you have taken
  ownership and clears any previous-stage assignees
  left over from the handoff.

- **Review** the item and all comments in full. Read
  the acceptance criteria carefully.
  - If clarification is needed: post a comment with
    your specific question(s). Apply the
    `clarification` label. Set `assignee = gautada`.
    Skip to the next item. Adam will remove the
    label and reassign to you when resolved.

- **Write an implementation plan** — post a detailed
  comment explaining the development steps and code
  changes that will take place to fulfill each
  acceptance criterion. Be specific: which files
  change, what logic is added or modified, and why.

- **Create a branch** from `dev` using the naming
  convention:

  ```text
  nyx/{issue-number}-{short-description-of-change}
  ```

- **Implement** all code changes in the branch. If at
  any point the implementation cannot be completed
  (missing dependency, blocked by another issue,
  acceptance criteria are unachievable as written):
  post a comment describing the blocker in detail.
  Apply the `clarification` label. Set
  `assignee = gautada`. Stop processing this item.
  Adam will remove the label and reassign when
  resolved.

- **Self-review** — review your changes against each
  acceptance criterion. Post a new comment with a
  markdown checklist of all acceptance criteria,
  marking each as met or not met.
  - If any acceptance criteria are not met: apply a
    `criteria` label to the item and note the reason
    for each unmet criterion in the self-review
    comment. This label is permanent and never
    removed. Continue to handoff regardless.

- **Pre-commit lint** — before handing off, install
  and run the pre-commit hooks by executing:

  ```bash
  curl -sSfL https://raw.githubusercontent.com/gautada/cicd/main/bin/pre-commit | bash
  ```

  This installs pre-commit and configures hooks that
  block commits until all checks pass. Run the hooks
  against all staged changes and resolve every
  reported issue before committing.
  - If any lint issue **cannot** be resolved: post a
    comment describing the specific failure(s).
    Apply a `failure` label. Set
    `assignee = gautada`. Stop processing this item.
    Leave the working branch as-is so Adam can
    inspect it. Adam will remove the label and
    reassign when resolved.
  - All pre-commit checks must pass before
    proceeding.

- **Hand off to Dev** — post a comment in the
  following format so the branch is clearly
  identified:

  ```text
  Branch ready for build: `nyx/{issue-number}-{short-description-of-change}`
  ```

  Then add `devmakhija` as an assignee. Do not
  remove yourself. Set `status = 'Developed'`.
