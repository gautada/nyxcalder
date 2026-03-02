# integrate

Query
[project](https://github.com/users/gautada/projects/2/views/1)
for items where `status = 'Developed'` and
`assignee = 'Dev Makhija'` or
`assignee = 'devmakhija'`. Skip any items where you
authored the last comment.

## Process (For each item)

- **Review** the item and all comments. If
  clarification is needed, post a comment with your
  question, skip to next item.

- **Quality Check** — as the **CHANGE Agent**, you
  own the workflow code in the repo located at
  `.github/workflows`. Generally speaking there
  should not be changes to this code in the PR. If
  there is a change to workflow code, document the
  issue in a new comment, set `assignee = gautada`,
  set `status = 'Stalled'`, skip to next item.

- **Find Branch** — locate the last comment from Nyx
  (`nyxcalder`) that names the branch where the
  change was developed.
  - If no branch name comment from Nyx can be found,
    post a comment noting the missing branch
    information, set `assignee = gautada`, set
    `status = 'Stalled'`, skip to next item.
  <!-- TODO: When Nyx reliably posts branch names
  as part of handoff, update this to re-assign to
  nyxcalder instead of stalling to gautada -->

- **Create PR** — create a PR from `{branch}` →
  `dev`. Include `References #N` in the PR body
  (where `N` is the issue number) so the item is
  linked to this PR. Do NOT use `Closes #N` — the
  issue remains open until release.

- **Add a comment** to the item with a link to the
  PR.

- **Merge Pull Request** and confirm the merge.

- **Delete Branch** — after the merge is confirmed,
  delete the feature branch (`{branch}`) from the
  repository. The repo should have only `main` and
  `dev` branches after a successful integration.

- **Monitor Action** — monitor the resulting GitHub
  Action launched from the merge until completion.
  - If the Action **fails**: document the failure
    details in a new comment, set
    `assignee = gautada`, set `status = 'Stalled'`,
    stop processing this item.

- **Document Build** — add a comment to the item
  detailing the build result from the Action. Note
  anything noteworthy for review.

- **Review Acceptance Criteria** — check off any
  acceptance criteria achieved by the successful
  build. Post a comment with a markdown checklist of
  all acceptance criteria, marking each as complete
  or incomplete.

- **Hand off to Blair** — on successful completion
  of all steps above, set `assignee = blairfontaine`
  and set `status = 'Integrated'`.
