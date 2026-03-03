# Execution Protocol: Cohort/Plan/README

When Adam tags a repo with the `plan-readme` topic,
I go into "README planner" mode. This document is my
playbook so I can drop in, create/update a planning
branch, and hand Adam a Ready-to-review PR + project
item with zero loose ends.

---

## 0. Prereqs

- `gh` CLI authenticated with `GITHUB_PA_PLAN_TOKEN`.
- Push access to all `gautada/*` repos (already granted).
- URL for the **eureka!FARMS** project board ([eureka!FARMS project board](https://github.com/users/gautada/projects/2/views/3)).

---

## 1. Discover active repos

1. List every repo carrying the `plan-readme` topic:

   ```bash
   gh repo list gautada \
     --topic plan-readme \
     --json nameWithOwner,description,sshUrl \
     --limit 200
   ```

2. If the command returns an empty array, stop —
   there is no work.
3. Otherwise, process each repo in alphabetical
   order (oldest untouched first if timestamps
   available).

Document progress in `notes.md` inside each plan
branch.

---

## 2. Hydrate the repo

For each repo identified above:

1. Clone if needed: `git clone <repo-url>`.
2. `cd <repo>` and `git fetch --all --prune`.
3. Inspect remote branches: `git branch -r`.

---

## 3. Ensure `dev` baseline

1. Check if `origin/dev` exists.
2. If **yes**: `git checkout dev && git pull`.
3. If **no**: create it from `main` (or default)
   and push:

   ```bash
   git checkout -b dev origin/main
   git push -u origin dev
   ```

All plan work starts from the latest `dev` branch.

---

## 4. Create a planning branch

1. Choose a slug that reflects the change, e.g.
   `plan/readme-refresh`, `plan/platform-docs`, etc.
2. `git checkout -b plan/<slug> origin/dev`.
3. Create `notes.md` (if missing) and capture:
   - Repo state summary
   - Branch inventory & stale items
   - Issue audit takeaways
   - README gaps + proposed fixes

---

## 5. Audit & update README

Run this checklist for every README in the repo
(root + major subdirs):

| Section | Requirement |
| --- | --- |
| Overview | Purpose, owner, status |
| Architecture | Diagrams or components |
| Environments | Dev/stage/prod URLs |
| Setup | Bootstrap instructions |
| Operations | Deploy, test, secrets |
| Planning hooks | Open issues, plan branch |
| Contact | Point-of-contact, escalation |

Rules:

- Use tables or callouts when it improves
  scanability.
- Assume Nyx is the reader: no fluff, no TODO
  placeholders.
- Keep instructions repo-specific — no generic
  "TBD".
- If work spans multiple files (e.g.,
  `/docs/README.md`), fix them in the same branch.

---

## 6. Git hygiene

1. `git status` should show only intended
   README/docs/notes changes.
2. Format Markdown (`markdownlint` if configured)
   and spell-check critical names.
3. Commit message format:
   `chore: refresh README plan context`
   (tweak verb as needed).

---

## 7. Push & open PR

1. `git push -u origin plan/<slug>`.
2. Open a PR targeting `dev`:

   ```bash
   gh pr create \
     --base dev \
     --head plan/<slug> \
     --title "Plan: <short summary>" \
     --body "See notes in /cohort/plan for context." \
     --assignee @gautada
   ```

3. Include checklist items in the PR body if
   multiple READMEs changed.

---

## 8. Project tracking

For each PR:

1. Open the **Eureka FARMS** project board.
2. Create a new item under "Ready" with:
   - **Title:** `Review README plan for <repo>`
   - **Assignee:** Adam
   - **Status:** Ready
   - **Body:** Link to the PR + summary of what
     changed.

---

## 9. Hand-off

1. DM Adam (or comment on the PR) with:
   - Link to the PR
   - Link to the project item
   - One-paragraph summary + any blocking questions
2. Using the current understanding of the repository
   and the updated readme. Create a very short and
   concise description and update the repository's
   description.
3. Remove the `plan-readme` topic on the repo.

---

## Definition of Done

- Every `plan-readme` repo has an up-to-date README
  that satisfies the checklist above.
- A plan branch exists off `dev` with the
  documentation changes.
- PR assigned to Adam + matching Eureka FARMS
  project item in "Ready".
