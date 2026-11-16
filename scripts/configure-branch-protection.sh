#!/usr/bin/env bash
# Protect the default branch of one repository with a ruleset:
# pull request required, force pushes and deletion blocked.
# Usage: [DRY_RUN=1] ./scripts/configure-branch-protection.sh ORG REPO [REQUIRED_APPROVALS]
set -euo pipefail

ORG="${1:-}"; REPO="${2:-}"; APPROVALS="${3:-1}"
[ -n "$ORG" ] && [ -n "$REPO" ] || { echo "usage: $0 ORG REPO [APPROVALS]" >&2; exit 2; }

body=$(jq -n --argjson n "$APPROVALS" '{
  name: "protect-default-branch",
  target: "branch",
  enforcement: "active",
  conditions: { ref_name: { include: ["~DEFAULT_BRANCH"], exclude: [] } },
  rules: [
    { type: "deletion" },
    { type: "non_fast_forward" },
    { type: "pull_request", parameters: {
        required_approving_review_count: $n,
        dismiss_stale_reviews_on_push: true,
        require_code_owner_review: false,
        require_last_push_approval: false,
        required_review_thread_resolution: false } }
  ]
}')

if [ "${DRY_RUN:-0}" = 1 ]; then
  echo "[dry-run] POST repos/$ORG/$REPO/rulesets"; echo "$body"; exit 0
fi

echo "$body" | gh api -X POST "repos/$ORG/$REPO/rulesets" --input - --jq '"ok    ruleset " + (.id|tostring) + " created on '"$ORG/$REPO"'"'
echo "note  rulesets on private repos need a paid plan; on Free use public repos or classic branch protection"
