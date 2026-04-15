# code

Read, understand, and apply the
[develop](https://github.com/gautada/eurekafarms/blob/main/standards/develop.md)
standard before proceeding.

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

- **Implementation plan** — Write a detailed
  comment explaining the development steps and code
  changes that will take place to fulfill each
  acceptance criterion. Be specific: which files
  change, what logic is added or modified, and why.

- **Create a branch** If implementation plan
  defines changes.  then create a branch from
  `dev` using the naming
  convention:

  ```text
  nyx-{issue-number}-{short-description-of-change}
  ```

  Add a new comment as
  ```text
  Branch ready for build: `nyx/{issue-number}-{short-description-of-change}`
  ```

- **Sync coding templates** — From the repository root run:

```sh
curl -sSfL https://raw.githubusercontent.com/gautada/cicd/refs/heads/main/templates/gitignore/.gitignore > .gitignore

TEMPLATE=$(gh repo view --json repositoryTopics \
-q '.repositoryTopics.nodes[].topic.name' | awk -F'cicd-' '/^cicd-/ { print $2; exit }')

if [ -z "$TEMPLATE" ]; then
echo "ERROR: repository is missing a cicd-* topic (e.g., cicd-container)" >&2
exit 1
fi

mkdir -p .github/workflows
curl -sSfL "https://raw.githubusercontent.com/gautada/cicd/refs/heads/main/templates/cicd/${TEMPLATE}.yaml" \
-o .github/workflows/cicd.yaml

curl -sSfL https://raw.githubusercontent.com/gautada/cicd/main/bin/pre-commit | bash -- --pull-only
```

- **Implement** *IF* a new branch exists make all code changes
  in new the branch. If at any point the implementation cannot be completed
  (missing dependency, blocked by another issue,
  acceptance criteria are unachievable as written):
  post a comment describing the blocker in detail.
  Apply the `issue` label. Set
  `assignee = gautada`. Stop processing this item.

- **Self-review** — review your changes against each
  acceptance criterion. Post a new comment with a
  markdown checklist of all acceptance criteria that you
  completed and achieved

- **Pre-commit lint** — Before handing off, run
  `pre-commit run --all-files` (or the equivalent
  linting/static-analysis tool configured for the
  repository). Correct every issue raised by the
  command and note any notable clean-ups in an issue
  comment so later stages understand the adjustments
  you made.
  
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

- Add the next assignee (for this process the next asignee is 'devmakhija') to the issue.
- Move the status of this issue to "Developed". 
  
