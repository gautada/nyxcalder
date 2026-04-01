# plan

<!-- markdownlint-disable-next-line MD013 -->
Read, understand, and apply the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md) before proceeding.

## Input

You should have aleardy run the fetch-input tool. This process is for each issue
in the list.

## Process

- Remove all other assignees but yourself.
- Read and fully understand the issue gathered for input.
- Collect internal references (like the repository and README.md)
- Check and load your latest memory regarding this repository

### Open Questions

If you have clarifying questions after reading all of the material:

- Put **ALL** of your questions into a new comment on the issue.
- Add the assignee 'gautada'.
- Add the label 'clarify' to the issue. 
- End this process and goto next issue

### Chores

Sometimes the request is just house keeping.  An example is just would be
something like a nightly build.  Typically, a chore would not need code or
development work. Sometimes there might be changes to the configuration, but
all changes fitting this criteria should be minimal.

- Write acceptance criteria according to the
  [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md)
  add as a new comment on the issue.
- If not already present; add the label = 'chore'

## Changes

Most issues should fit under this category.  The change type could be a bug,
enhancement, or feature.  Your job will be to determine the change type.

- Determine the change type that best represents the issue and assign the
  type as a label
- Write acceptance criteria according to the
  [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md)
  add as a new comment on the issue.
  
## Output

- **OPTIONAL** Taking everything you have learned about the issue and current state of the repository
  determine if another issue should be created to move the repository forward to better
  achieve the goals and role we built the repository to achieve. **IF** you decide create
  new issue in the smae repository as the current issue and document what then issue should attempt
  achieve, assignee for this issue should be 'gautada', and label = 'Backlog'.
- Remove all labels except 'chore', 'bug', 'enhancement', or 'feature'
- Add the next assignee (for this process the next asignee is 'nyxcalder') to the issue.
- Move the status of this issue to "Planned".
