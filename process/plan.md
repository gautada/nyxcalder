# plan

Read, understand, and apply the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md) before proceeding.

## Query

Run the following command to find your work items:

```bash
gh api graphql -f query='
{
  user(login: "gautada") {
    projectV2(number: 2) {
      items(first: 50) {
        nodes {
          id
          status: fieldValueByName(name: "Status") {
            ... on ProjectV2ItemFieldSingleSelectValue { name }
          }
          assignees: fieldValueByName(name: "Assignees") {
            ... on ProjectV2ItemFieldUserValue {
              users(first: 5) { nodes { login } }
            }
          }
          content {
            ... on Issue {
              number title repository { name }
              comments(last: 1) { nodes { author { login } } }
            }
          }
        }
      }
    }
  }
}'
```

Filter results to items where `status = 'Inbox'` and `assignees` includes `blairfontaine`. Skip any item where the last comment was authored by `blairfontaine`.

## Process (For each item):

- **Review** the item and all comments in full.
  - If clarification is needed: post a comment with your specific question(s). Apply the `clarification` label to the item. Remove yourself as assignee and set `assignee = gautada`. Skip to the next item.
  - If a clarifying question you posted in a previous cycle remains unanswered: post a comment noting the question is still pending. Ensure the `clarification` label is applied. Ensure `assignee = gautada` (remove yourself if still assigned). Set `status = 'Stalled'`. Skip to the next item.
  - If the item is too vague to write testable criteria even after review: post a comment describing what information is missing. Apply the `clarification` label. Remove yourself as assignee and set `assignee = gautada`. Set `status = 'Stalled'`. Skip to the next item.

- **Write acceptance criteria** — post a single comment containing a markdown checklist of all acceptance criteria per the [criteria standard](https://github.com/gautada/eurekafarms/blob/main/standards/criteria.md). Include at least one stretch criterion, clearly flagged.

- **Hand off to Nyx** — once all clarifying questions are answered and acceptance criteria are written, set `assignee = nyxcalder` and set `status = 'Planned'`.
