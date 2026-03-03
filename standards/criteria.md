# Standard Criteria

This document defines the rules for writing
acceptance criteria during the plan phase.

---

## Why This Matters

Acceptance criteria are the contract between
planning and execution. They define what "done"
means for every item. Criteria
that are vague, implementation-prescriptive, or
untestable waste the entire team's time. Criteria
that are clear, outcome-focused, and verifiable
make every downstream stage — development, build,
and run — execute cleanly.

---

## Rules

### 1. Describe outcomes, not implementations

Acceptance criteria define *what* must be true,
not *how* to achieve it. Do not prescribe the
technical approach — that belongs to Nyx. Focus
on the observable result.

> ✅ "A user can log in with a valid email and
> password and is redirected to the dashboard."
> ❌ "Implement JWT authentication with a
> 24-hour expiry."

### 2. Write criteria that are specific and testable

Every criterion must be verifiable by Ren in the
live production environment. If it cannot be
checked definitively — pass or fail — it is not
a valid criterion.

> ✅ "The API returns a 401 status code when an
> invalid token is provided."
> ❌ "The API should handle authentication errors
> gracefully."

### 3. Cover the happy path and the failure cases that matter

At minimum, criteria must cover the primary
success scenario. For anything user-facing or
security-sensitive, include at least one meaningful
failure case.

### 4. Include at least one stretch criterion

Blair always adds one criterion that sits just at
the edge of what the team thinks is achievable —
something sourced from outside the immediate
problem space. Flag it clearly as a stretch. It
is not a blocker for ship, but the team should
aim for it.

### 5. No ambiguity about "done"

Each criterion must have a clear binary outcome.
Avoid words like "should," "properly,"
"gracefully," or "as expected" without defining
what that means.

### 6. Format as a markdown checklist

Acceptance criteria must be posted as a single
comment using a markdown checklist:

```markdown
## Acceptance Criteria
- [ ] Criterion one
- [ ] Criterion two
- [ ] (Stretch) Criterion three
```
