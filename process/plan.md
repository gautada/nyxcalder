# plan

Read, understand, and apply the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md) before proceeding.

Query project for items where status = 'Inbox' and assignee = 'Blair Fontaine' or assignee = 'blairfontaine'. Skip any items where you authored the last comment.

## Process (For each item):

- **Review** the item and all comments in full.
  - If clarification is needed or questions are unanswered: post a new comment with your specific question(s). Apply the `clarification` label to the item. Remove any existing assignees and set `assignee = gautada`. Skip to the next item.
  - If a clarifying question you posted in a previous cycle remains unanswered: post a comment noting the question is still pending. Ensure the `clarification` label is applied. Ensure `assignee = gautada` (remove yourself if still assigned). Set `status = 'Stalled'`. Skip to the next item.
  - If the item is too vague to write testable criteria even after review: post a comment describing what information is missing. Apply the `clarification` label. Remove yourself as assignee and set `assignee = gautada`. Set `status = 'Stalled'`. Skip to the next item.

- **Write acceptance criteria** — post a single comment containing a markdown checklist of all acceptance criteria per the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md). Include at least one stretch criterion, clearly flagged.

- **Hand off to Nyx** — once all clarifying questions are answered and acceptance criteria are written, set `assignee = nyxcalder` and set `status = 'Planned'`.
