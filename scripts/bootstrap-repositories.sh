#!/usr/bin/env bash
# Create the organization's shared .github repository (community files and
# profile README) and an optional first repository.
# Usage: [DRY_RUN=1] ./scripts/bootstrap-repositories.sh ORG [FIRST_REPO]
set -euo pipefail

ORG="${1:-}"
FIRST="${2:-first-repo}"
[ -n "$ORG" ] || { echo "usage: $0 ORG [FIRST_REPO]" >&2; exit 2; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DRY="${DRY_RUN:-0}"
run() { if [ "$DRY" = 1 ]; then echo "[dry-run] $*"; else "$@"; fi; }

exists() { gh repo view "$ORG/$1" >/dev/null 2>&1; }

if exists .github; then
  echo "skip  $ORG/.github already exists"
else
  run gh repo create "$ORG/.github" --public \
    --description "Organization-wide community health files and profile"
fi

if [ "$DRY" != 1 ]; then
  work="$(mktemp -d)"
  trap 'rm -rf "$work"' EXIT
  gh repo clone "$ORG/.github" "$work/gh" -- --quiet
  mkdir -p "$work/gh/profile"
  cp "$ROOT/templates/community/"*.md "$work/gh/"
  cp "$ROOT/templates/organization-profile/README.md" "$work/gh/profile/README.md"
  (cd "$work/gh" && git add -A && \
    { git diff --cached --quiet || git commit -s -q -m "chore: add community files and profile README" && git push -q; })
  echo "ok    published community files to $ORG/.github"
else
  echo "[dry-run] would copy templates/community/*.md and the profile README into $ORG/.github"
fi

if exists "$FIRST"; then
  echo "skip  $ORG/$FIRST already exists"
else
  run gh repo create "$ORG/$FIRST" --private --add-readme \
    --description "First repository"
fi
