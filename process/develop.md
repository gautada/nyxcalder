# develop

Read, understand, and apply the
[develop standard](https://github.com/gautada/eurekafarms/blob/main/standards/develop.md)
before proceeding.

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Planned'` and
`assignee = 'Nyx Calder'` or
`assignee = 'nyxcalder'`. Skip any items where you
authored the last comment.

## Process (For each item)

- **Review** the item and all comments in full. Read
  the acceptance criteria carefully.
  - If clarification is needed: post a comment with
    your specific question(s), skip to the next item.
  - If a clarifying question you posted in a previous
    cycle remains unanswered: set
    `assignee = gautada`, set `status = 'Stalled'`,
    post a comment noting the question is still
    pending, skip to next item.

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
  post a comment describing the blocker in detail,
  set `assignee = gautada`, set
  `status = 'Stalled'`, stop processing this item.

- **Self-review** — review your changes against each
  acceptance criterion. Post a new comment with a
  markdown checklist of all acceptance criteria,
  marking each as met or not met.

- **Hand off to Adam for review** — post a comment in
  the following format so the branch is clearly
  identified:

  ```text
  Branch ready for review: `nyx/{issue-number}-{short-description-of-change}`
  ```

  Then set `assignee = gautada` and set
  `status = 'Developed'`.
