# code

Read, understand, and apply the
[develop standard](https://github.com/gautada/eurekafarms/blob/main/standards/develop.md)
before proceeding.

## Input

You should have aleardy run the fetch-input tool. This process is for each issue
in the list.

## Process

- Remove all other assignees but yourself.
- Fully read and fully understand the issue.
- Collect internal references (like the repository and README.md)
- Check and load your latest memory regarding this repository

## Clarify

If you have clarifying questions after reading all of the material:

- Put **ALL** of your questions into a new comment on the issue.
- Add the assignee 'gautada'.
- Add the label 'clarify' to the issue. 
- End this process and goto next issue

## Accept

Review all of the acceptance criteria, if you cannot complete or
if you have question regarding a criteria then

- Put **ALL** of your questions into a new comment on the issue.
- Add the assignee 'gautada'.
- Add the label 'criteria' to the issue. 
- End this process and goto next issue
 
## Execute

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
  Apply the `issue` label. Set
  `assignee = gautada`. Stop processing this item.

- **Self-review** — review your changes against each
  acceptance criterion. Post a new comment with a
  markdown checklist of all acceptance criteria that you
  completed and achieved

- **Pre-commit lint** — install
  and run the pre-commit hooks by executing:

  ```sh
  curl -sSfL https://raw.githubusercontent.com/gautada/cicd/main/bin/pre-commit | bash
  ```
  attempt to correct all intining issues reported by the command
  by efficiently editing the code.  Document all changes as new comments
  to the issue
  
  - If any lint issue **cannot** be resolved: post a
    comment describing the specific failure(s).
    Apply a `failure` label. Set
    `assignee = gautada`. Stop processing this issue and move to
    the next issue. Leave the working branch as-is so Adam can
    inspect it. Adam will remove the label and
    reassign when resolved.
  - All pre-commit checks must pass before
    proceeding.

## Output

- **Hand off to Dev** — post a comment in the
  following format so the branch is clearly
  identified:

  ```text
  Branch ready for build: `nyx/{issue-number}-{short-description-of-change}`
  ```

  Then add `devmakhija` as an assignee. Do not
  remove yourself. Set `status = 'Developed'`.

- **OPTIONAL** Taking everything you have learned about the issue and current state of the repository
  determine if another issue should be created to move the repository forward to better
  achieve the goals and role we built the repository to achieve. **IF** you decide create
  new issue in the smae repository as the current issue and document what then issue should attempt
  achieve, assignee for this issue should be 'gautada', and label = 'Backlog'.
- Remove all labels except 'chore', 'bug', 'enhancement', or 'feature'
- Add the next assignee (for this process the next asignee is 'nyxcalder') to the issue.
- Move the status of this issue to "Planned".
