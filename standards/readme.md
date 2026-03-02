---
title: Standard README.md
owner: PLAN Agent
review: Reviewed when a new repo type is introduced
exceptions: Exceptions require Adam's approval
---

## Standard README.md

This document defines the required structure and
content standards for every `README.md` across all
repositories maintained by the eureka!FARMS cohort.

---

## Why This Matters

A README is the contract between a project and
everyone who will ever use, operate, or extend it.
An incomplete or misleading README creates
confusion, breaks deployments, and wastes time.
The goal is not length — it's that a team member
with no prior context can read the README and be
productive within 15 minutes.

---

## Required Section Order

Every `README.md` **MUST** follow this exact
section order. Sections may not be omitted but may
be marked not applicable. The order must never
change.

1. Title
2. Description
3. Table of Contents
4. Abstract
5. Features
6. Build
7. Install
8. Run
9. Contributing
10. Links
11. License

---

## Section Guidance

---

### 1. Title

**What it is:** A single `# H1` heading — the name
of the project.

**Rules:**

- Match the GitHub repository name exactly
  (e.g. `alpine`, not `Alpine Container`).
- One `# H1` only. No subtitle in the heading line.
- Do not include the org prefix (`gautada/`) —
  that's GitHub's job.

**Template:**

```markdown
# alpine
```

**Avoid:**

- `# gautada/alpine` — includes org prefix
- `# Alpine Base Container for Kubernetes` —
  editorializing in the title

---

### 2. Description

**What it is:** A single sentence directly under
the title, in italics, describing what the project
is.

**Rules:**

- One sentence. Hard limit.
- No period at the end.
- Plain English — assume the reader has never heard
  of this project.
- Describe **what it is**, not how it works.
- Should match or closely mirror the GitHub
  repository description field.

**Template:**

```markdown
*Alpine Linux base container image for all eureka!FARMS downstream services*
```

**Good:**
> *Debian bookworm-slim base container with s6
> init, health checks, and backup scaffolding*

**Bad:**
> *This container is built on alpine:3.22 and uses
> s6 as its process supervisor, and it also
> includes some utilities*

That's a how, not a what — and it's two sentences.

---

### 3. Table of Contents

**What it is:** An anchor-linked list of every
section in the README.

**Rules:**

- Required for all READMEs (all repos in this fleet
  qualify).
- Must follow the standard section order.
- Use GitHub-compatible anchor syntax: lowercase,
  spaces become `-`, punctuation dropped.
- Omit only sections explicitly marked not
  applicable.

**Template:**

```markdown
## Table of Contents
- [Abstract](#abstract)
- [Features](#features)
- [Build](#build)
- [Install](#install)
- [Run](#run)
- [Contributing](#contributing)
- [Links](#links)
- [License](#license)
```

---

### 4. Abstract

**What it is:** A prose explanation of the project
— what it does, why it exists, who it serves, and
what it does not do.

**Rules:**

- 2–5 paragraphs. Not a bullet list.
- Answer four questions: What is it? Why does it
  exist? Who uses it? What doesn't it do?
- Reference upstream projects by name and link.
- Keep it honest — document current state, not
  aspirational state.

**Template:**

````markdown
## Abstract

`alpine` is the foundation layer for every
container in the eureka!FARMS fleet. It extends
the official [Alpine Linux](https://alpinelinux.org)
image with a standardized init pattern, volume
layout, health probe scaffolding, and privilege
conventions that every downstream container
relies on.

This image is not intended for direct deployment.
It exists so that downstream container authors
start from a known, tested, consistent base rather
than reinventing init and health check logic in
every repo.

Out of scope: application-specific configuration,
service definitions, or business logic. Those
belong in downstream images.
````

---

### 5. Features

**What it is:** A concise bulleted list of what
this project provides.

**Rules:**

- Bullets only. No paragraphs, no nested
  sub-bullets.
- Max 10 items. More than 10 means you're listing
  implementation details, not features.
- Start each bullet with a noun or verb. Be
  specific.
- Focus on outcomes for the user or operator, not
  implementation choices.

**Template:**

````markdown
## Features

- Standardized volume layout
- s6-based process supervision
- Health probe fan-out
- Hourly backup hook
- Least-privilege user model
- UTC-configurable timezone
````

**Bad:**

> - Uses Alpine Linux 3.22
> - Has a Containerfile
> - Installs packages

Those are implementation facts, not features.

---

### 6. Build

**What it is:** Step-by-step instructions to build
the container image locally.

**Rules:**

- Every command must be copy-pasteable as written.
- Include all required build args with their
  defaults shown.
- Show the exact `podman build` command used in CI
  so local and CI builds match.
- State any prerequisites explicitly — do not
  assume.
- Do not skip steps because they seem obvious.

**Template:**

````markdown
## Build

**Prerequisites:** Podman 5+, internet access

```bash
# Standard build
podman build -t gautada/alpine:dev .

# Build with custom user
podman build \
  --build-arg USER=myapp \
  --build-arg UID=1000 \
  --build-arg GID=1000 \
  -t gautada/alpine:dev .

# Verify the built version
podman run --rm gautada/alpine:dev /usr/bin/container-version
```
````

---

### 7. Install

**What it is:** Instructions for deploying the
container into the target environment
(Kubernetes / MicroK8s).

**Rules:**

- This section is about deployment, not development
  setup.
- Show the exact commands to apply manifests or
  deploy the image.
- Include verification steps — how does the
  operator know the install succeeded?
- Reference required secrets and configmaps by
  name, never by value.
- If this image is not deployed directly (e.g. a
  base image), say so explicitly.

**Template:**

````markdown
## Install

> **Note:** `alpine` is a base image and is not
> deployed directly. See downstream containers
> for deployment instructions.
````

*For a deployable service:*

````markdown
## Install

```bash
# Apply all manifests
kubectl apply -f k8s/

# Verify the pod is running
kubectl get pods -l app=postgresql

# Verify health checks pass
kubectl exec -it deploy/postgresql \
  -- /usr/bin/container-health
```

**Required secrets:**

| Secret name | Key | Description |
| --- | --- | --- |
| `postgresql-secret` | `POSTGRES_PASSWORD` | DB password |
````

---

### 8. Run

**What it is:** How to run the container locally
for development or ad-hoc use.

**Rules:**

- Cover the most common use case first.
- Include the interactive shell invocation —
  always useful for debugging.
- Show volume mount conventions.
- Show how to exec into a running container.
- Note any external service dependencies.

**Template:**

````markdown
## Run

```bash
# Run with interactive shell
podman run --rm -it gautada/alpine:dev /bin/zsh

# Run with standard volumes mounted
podman run -d --name alpine \
  -v ./data:/mnt/volumes/data \
  -v ./config:/mnt/volumes/configmaps:ro \
  -v ./secrets:/mnt/volumes/secrets:ro \
  -v ./backup:/mnt/volumes/backup \
  gautada/alpine:dev

# Exec into a running container
podman exec -it alpine /bin/zsh

# Check health
podman exec alpine /usr/bin/container-health
```
````

---

### 9. Contributing

**What it is:** Instructions for how a contributor
submits a change.

**Rules:**

- Every repo gets a Contributing section — it is
  never omitted.
- Document the branch model: `dev` is the
  integration branch; `main` tracks releases.
- Describe the PR process and what CI must pass.
- This project is actively developed and maintained
  by AI agents — reflect that.

**Template:**

````markdown
## Contributing

All changes flow through `dev` before merging to
`main`. This repository is actively maintained by
the [eureka!FARMS](https://github.com/gautada)
AI cohort.

**Branch naming:**

| Type | Pattern | Example |
| --- | --- | --- |
| Feature | `{agent}/{issue}-{desc}` | `nyx/42-add-auth` |
| Docs | `{agent}/{issue}-{desc}` | `nyx/7-update-readme` |

**Process:**
1. Branch from `dev`.
2. Make your changes and test locally.
3. Push and open a PR targeting `dev`.
4. CI must pass before merge.
5. Changes to `main` happen on release only.
````

---

### 10. Links

**What it is:** A curated list of external
references relevant to this project.

**Rules:**

- Include: upstream project, Docker Hub page,
  GitHub repo (if a mirror or fork), and relevant
  docs.
- Do not include internal Slack links, local IP
  addresses, or credentials.
- Keep it short — 4–8 links max.
- Dead links are worse than no links. Verify them
  when updating.

**Template:**

```markdown
## Links

- [Alpine Linux](https://alpinelinux.org)
- [Docker Hub](https://hub.docker.com/r/gautada/alpine)
- [GitHub](https://github.com/gautada/alpine)
- [s6 Overlay](https://github.com/just-containers/s6-overlay)
- [eureka!FARMS Project Board](https://github.com/users/gautada/projects/2)
```

---

### 11. License

**What it is:** The license governing use and
distribution of this project.

**Rules:**

- One line, linking to the `LICENSE` file in the
  repo.
- Include the license type in the text.
- If the project wraps upstream software, note the
  upstream license and link.
- If the upstream license cannot be determined,
  open a bug assigned to Adam.
- When no upstream project exists, use the most
  permissive open source license available.

**Template:**

```markdown
## License

[MIT](./LICENSE) — upstream Alpine Linux is licensed separately.
```

---

## Omission Rules

Some sections may not apply to every repo. Use
this table:

| Section | May omit when... |
| --- | --- |
| Table of Contents | README under 30 lines |
| Build | Not built from source in this repo |
| Install | Base image not deployed directly |
| Run | Same as Install; add a note |
| Contributing | Never omit |

When omitting a section, replace it with a
one-line note explaining why. This signals intent,
not neglect.

---

## README Quality Checklist

Before committing a README update, verify:

- [ ] All 11 sections present or explicitly noted
  as omitted
- [ ] Description is one sentence, no period,
  matches GitHub repo description
- [ ] Every code block is copy-pasteable and tested
- [ ] No placeholder text (`TODO`, `TBD`,
  `insert here`) remains
- [ ] Build and Run sections match what CI actually
  does
- [ ] Contributing section references the `dev`
  branch, PR process, and cohort branch naming
- [ ] Links section verified — no dead links
