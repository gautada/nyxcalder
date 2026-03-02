# github

Instructions for setting up an agent in github.

## Pre-Work. Setup email and check gh user name

- Email setup as alias in fastmail, dont forget to
  add a rule to put emails into a folder.
- Make sure the user name = `lower(firstlast)`

## Step 1: Setup Profile

- Add headshot
- In **Profile** / **Emails** /
  **Keep my email addresses private**: Toggle On
- In **Profile** / **Emails** /
  **Block command line pushes that expose my email**:
  Toggle On

## Step 2: Add to a project

- Login as me and add the cohorts to the project

## Step 3: Setup Personal Access Token

- Goto Account : Developer Settings / Personal Access
  Token / Fine Grained Tokens

**All agents — required baseline:**

| Permission | Level |
| --- | --- |
| Metadata | Read |

---

**:clipboard: Blair (Planning)**
Creates/manages issues, labels, milestones —
no code writes

| Permission | Level |
| --- | --- |
| Issues | Read + Write |
| Pull Requests | Read |
| Contents | Read |
| Projects | Read + Write |

---

**:arrows_counterclockwise: Dev (CI/CD)**
Triggers workflows, manages deployments, monitors
pipeline

| Permission | Level |
| --- | --- |
| Actions | Read + Write |
| Deployments | Read + Write |
| Environments | Read + Write |
| Workflows | Read + Write |
| Pull Requests | Read + Write |
| Contents | Read |
| Checks | Read + Write |
| Statuses | Read |

---

**:hammer_and_wrench: Nyx (Execution/Dev)**
Writes code, opens and reviews PRs, builds services

| Permission | Level |
| --- | --- |
| Contents | Read + Write |
| Pull Requests | Read + Write |
| Issues | Read + Write |
| Workflows | Read + Write |
| Checks | Read + Write |
| Actions | Read |
| Statuses | Read |

---

**:satellite_antenna: Ren (Runtime/Support)**
Reads logs, CI status, deployments — creates
incident issues only

| Permission | Level |
| --- | --- |
| Contents | Read |
| Issues | Read + Write |
| Actions | Read |
| Deployments | Read |
| Checks | Read |
| Pull Requests | Read |
| Statuses | Read |
