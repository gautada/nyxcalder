#!/usr/bin/env zsh
set -euo pipefail

# token="$GITHUB_PA_PLAN_TOKEN"
# if [[ -z "$token" ]]; then
# echo "GITHUB_PA_PLAN_TOKEN not set" >&2
# exit 1
# fi
#
# cohorts blairfontaine, nyxcalder, devmakhija, rennakatomi
cohort="rennakatomi"
repos=$(gh repo list gautada --no-archived --source --limit 1000 --json name --jq '.[].name')
missing=()
active=()
for repo in ${(f)repos}; do
 has_access=false
 # gh api returns 204 when the user *is* a collaborator, 404 otherwise
 if gh api --silent \
   "/repos/gautada/$repo/collaborators/${cohort}" >/dev/null 2>&1; then
  has_access=true
 fi
 if [[ $has_access != true ]]; then
  echo "# PATH = /repos/gautada/${repo}/collaborators/${cohort}"
  api_path="/repos/gautada/${repo}/collaborators/${cohort}"
  gh api --method PUT -H "Accept: application/vnd.github+json" \
    "$api_path" -f permission=push
  missing+="${repo} *"
 else
  active+=$repo
 fi
done

echo "Repos where blairfontaine is NOT a collaborator (no push access):"
printf '%s\n' $missing


echo "Repos where blairfontaine IS a collaborator:"
printf '%s\n' $active
