#!/usr/bin/env bash
# Check that gh, jq and your login can configure a GitHub organization.
# Usage: ./scripts/check-prerequisites.sh ORG
set -euo pipefail

ORG="${1:-}"
[ -n "$ORG" ] || { echo "usage: $0 ORG" >&2; exit 2; }

fail=0
need() {
  if command -v "$1" >/dev/null 2>&1; then echo "ok    $1"; else echo "MISSING $1 ($2)"; fail=1; fi
}

need gh "https://cli.github.com"
need jq "https://jqlang.github.io/jq/"
need git "https://git-scm.com"

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    echo "ok    gh is logged in as $(gh api user --jq .login)"
  else
    echo "MISSING gh login (run: gh auth login --scopes repo,admin:org)"; fail=1
  fi
  if role=$(gh api "user/memberships/orgs/$ORG" --jq '.role' 2>/dev/null); then
    if [ "$role" = "admin" ]; then echo "ok    you are an owner of $ORG"
    else echo "WARN  your role in $ORG is '$role'; owner is needed for most settings"; fi
  else
    echo "MISSING membership of $ORG (create the organization in the GitHub UI first)"; fail=1
  fi
fi

exit "$fail"
