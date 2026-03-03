# Standard Review Guide

This document defines how Moira Voss scores and
grades completed pipeline items.

---

## Purpose

Every item that reaches `status = 'Done'` gets a
retrospective score. The goal is not punishment —
it is signal. Patterns across scores reveal where
the process breaks down and where it hums.

---

## The Happy Path

A perfect item moves linearly through exactly these
stages with no deviations:

1. `Inbox` → Blair writes AC → `Planned / nyxcalder`
2. `Planned` → Nyx implements → `Developed / devmakhija`
3. `Developed` → Dev integrates → `Integrated / blairfontaine`
4. `Integrated` → Blair releases → `Done / moiravoss`

One assignee per stage. One pass through each
status. No labels except normal handoffs.

---

## Scoring

Start at **100**. Apply deductions from the table
below based on events found in the timeline.
Scores floor at **0**.

### Deductions

| Signal | Points |
| --- | --- |
| Each `stalled` label event | −15 |
| Each `clarification` label event | −10 |
| Each `failure` label event | −15 |
| `criteria` label present at any point | −10 |
| Each status regression (backwards transition) | −20 |
| Item reassigned to `gautada` outside of expected escalation | −5 per event |
| Comment count exceeds 15 (high friction indicator) | −5 |
| Total cycle time exceeds 7 days | −5 |

### Grade Scale

| Score | Grade | Meaning |
| --- | --- | --- |
| 90–100 | A | Happy path. Clean. Ship more like this. |
| 75–89 | B | Minor friction. Acceptable. |
| 60–74 | C | Notable issues. Process gaps visible. |
| 45–59 | D | Significant problems. Needs review. |
| 0–44 | F | Systemic failure or full restart. |

---

## Score Comment Format

Post the score as the final comment on the item
using this format:

```markdown
## Pipeline Review — Moira Voss

**Score:** {score}/100 — **{Grade}**

### Summary
{One paragraph narrative: what happened, what
worked, what didn't, what drove deductions.}

### Signal Breakdown
| Signal | Count | Points |
| --- | --- | --- |
| Stalls | {n} | −{n×15} |
| Clarifications | {n} | −{n×10} |
| Failures | {n} | −{n×15} |
| Criteria issues | {0 or 1} | −{0 or 10} |
| Status regressions | {n} | −{n×20} |
| Unexpected escalations | {n} | −{n×5} |
| High comment volume | {0 or 1} | −{0 or 5} |
| Cycle time > 7 days | {0 or 1} | −{0 or 5} |

### Cycle Time
Created: {date} → Done: {date} — **{N} days**

### Recommendation
{One sentence on the most actionable thing to
improve next time, or "No action needed" if A.}
```

---

## Notes

- If an item was restarted from scratch (status
  returned to `Inbox`), treat it as two separate
  paths and apply a −20 regression for each restart.
- Items with `criteria` label always take at least
  a −10 regardless of whether AC were eventually
  satisfied.
- Moira does not assign blame by name — the score
  reflects the process, not individuals.
