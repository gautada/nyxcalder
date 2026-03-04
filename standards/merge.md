# Standard Merge Guide

This document defines how all merges work in the
pipeline. All agents must follow these rules
without exception.

---

## Branch Model

Only two persistent branches exist in every
repository:

- `main` — production; receives merges only from `dev`
- `dev` — integration target; receives feature branches

All other branches are feature branches. They are
temporary and must be deleted after merge.

---

## Feature Branch → `dev` (Integration)

Owned by **Dev Makhija** (`devmakhija`).

- Feature branches follow the naming convention:
  `nyx/{issue-number}-{short-description-of-change}`
- PR is created from `{feature-branch}` → `dev`
- PR title: a clear, descriptive summary of the change
- PR body must include `References #N` (where `N`
  is the issue number) — this links the PR to the
  item without closing it
- Never use `Closes #N` — issues stay open until
  Blair closes them at release
- After merge: delete the feature branch immediately;
  only `main` and `dev` should remain

---

## `dev` → `main` (Release)

Owned by **Blair Fontaine** (`blairfontaine`).

- PR is created from `dev` → `main`
- PR title: the version identifier (e.g., `v2026.3.2`)
- PR body must include `References #N` for every
  issue included in the release
- After merge: create a version tag on `main`
  matching the PR title (e.g., `git tag v2026.3.2`)

---

## Rules

1. **Never push directly** to `main` or `dev` —
   all changes arrive via PR
2. **Never merge a feature branch to `main`** — it
   must flow through `dev` first
3. **Feature branches are always deleted** after merge
4. **`References #N` is required** in all PR bodies;
   `Closes #N` is never used
5. **Dev owns integration** (feature → dev);
   **Blair owns release** (dev → main)
6. **Workflow files are Dev's domain** — no other
   agent may modify `.github/workflows`; any PR
   containing such changes is a violation

---

## Label Reference
<!-- markdownlint-disable MD013 -->

| Label | Applied by | Meaning | Removed by |
| --- | --- | --- | --- |
| `clarification` | Any agent | Blocked pending Adam's answer | Adam, on resolution |
| `stalled` | Any agent | No activity for > 2 hours | Adam, manually |
| `failure` | Dev | CI/Action failed post-merge | Adam, on resolution |
| `criteria` | Blair or Nyx | One or more AC not fully met | Never — permanent |

<!-- markdownlint-enable MD013 -->
