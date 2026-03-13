#!/bin/bash
# github-project-status-check.sh
# Lists GitHub project issues in a specific status assigned to a specific user.
# Outputs a JSON array of matching issues.
#
# Usage: github-project-status-check.sh --owner <owner> --project <number> \
#                                        --assignee <user> --status <status> [--type org|user]
#
# Dependencies: gh (GitHub CLI), jq

set -euo pipefail

OWNER="${GITHUB_OWNER}"
OWNER_TYPE="${GITHUB_OWNER_TYPE}"
PROJECT_NUMBER="${GITHUB_PRJECT}"
ASSIGNEE=""
STATUS=""
STATE="OPEN"

usage() {
    cat >&2 <<EOF
Usage: $(basename "$0") --owner <owner> --project <number> --assignee <user> --status <status> [--state <state>] [--type org|user]

  --owner    GitHub organization or user login that owns the project
  --project  GitHub project number
  --assignee GitHub username to filter issues by
  --status   Status field name to filter by (e.g. "In Progress", "Todo", "Done")
  --state    Issue state to filter by (e.g. "OPEN", "CLOSED")
  --type     Owner type: 'org' (default) or 'user'
EOF
    exit 1
}

for cmd in gh jq; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: '$cmd' is required but not installed." >&2
        exit 1
    fi
done

while [[ $# -gt 0 ]]; do
    case "$1" in
        --owner|-o)    OWNER="$2";          shift 2 ;;
        --project|-p)  PROJECT_NUMBER="$2"; shift 2 ;;
        --assignee|-a) ASSIGNEE="$2";       shift 2 ;;
        --status|-s)   STATUS="$2";         shift 2 ;;
        --state)       STATE="$2";          shift 2 ;;
        --type|-t)     OWNER_TYPE="$2";     shift 2 ;;
        -h|--help)     usage ;;
        *) echo "Unknown option: $1" >&2; usage ;;
    esac
done

[[ -z "$OWNER" || -z "$PROJECT_NUMBER" || -z "$ASSIGNEE" || -z "$STATUS" ]] && usage

case "$OWNER_TYPE" in
    org)  OWNER_QUERY="organization(login: \$owner)" ;;
    user) OWNER_QUERY="user(login: \$owner)" ;;
    *)    echo "Error: --type must be 'org' or 'user'" >&2; exit 1 ;;
esac

# Build the GraphQL query dynamically based on owner type (org vs user).
# GitHub Projects v2 uses projectV2; items are fetched with fieldValues to
# identify which status (single-select Status field) each item is in.
QUERY="query(\$owner: String!, \$number: Int!) {
  ${OWNER_QUERY} {
    projectV2(number: \$number) {
      title
      items(first: 100) {
        nodes {
          content {
            ... on Issue {
              number
              title
              url
              state
              body
              createdAt
              updatedAt
              labels(first: 10) {
                nodes { name }
              }
              assignees(first: 10) {
                nodes { login }
              }
              comments(last: 50) {
                nodes {
                  author { login }
                  body
                  createdAt
                }
              }
            }
          }
          fieldValues(first: 20) {
            nodes {
              ... on ProjectV2ItemFieldSingleSelectValue {
                name
                field {
                  ... on ProjectV2SingleSelectField {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}"

gh api graphql \
    -f query="$QUERY" \
    -f owner="$OWNER" \
    -F number="$PROJECT_NUMBER" \
    | jq --arg assignee "$ASSIGNEE" --arg status "$STATUS" --arg state "$STATE" '
        (.data.organization.projectV2 // .data.user.projectV2).items.nodes
        | map(
            # Only process Issues (skip PRs and draft issues)
            select(.content | (type == "object") and (. != null)) |
            # Filter: at least one assignee matches the given username
            select(
                .content.assignees.nodes
                | map(.login)
                | any(. == $assignee)
            ) |
            # Filter: at least one field value matches the status name
            select(
                .fieldValues.nodes
                | map(objects | select(.name == $status))
                | length > 0
            ) |
            # Filter: issue state matches the provided state (if given)
            select(
                ($state == "") or (.content.state == $state)
            ) |
            # Filter out entire issue if latest comment is from the assignee
            select(
                (.content.comments.nodes | length == 0) or
                (.content.comments.nodes | last.author.login != $assignee)
            ) |
            # Return the issue content with flattened arrays
            .content | {
                number,
                title,
                url,
                state,
                body,
                createdAt,
                updatedAt,
                assignees: (.assignees.nodes | map(.login)),
                labels:    (.labels.nodes    | map(.name)),
                comments:  (.comments.nodes  | map({ author: .author.login, body, createdAt }))
            }
        )
    '
