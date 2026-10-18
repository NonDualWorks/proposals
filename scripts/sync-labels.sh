#!/usr/bin/env bash
# Create or update the repo's labels from .github/labels.yml.
# Usage: scripts/sync-labels.sh [owner/repo]   (defaults to the current repo)
set -euo pipefail

repo="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"
file="$(dirname "$0")/../.github/labels.yml"

grep -E '^- \{' "$file" | while IFS= read -r line; do
  name=$(sed -E 's/.*name: *"([^"]+)".*/\1/' <<<"$line")
  color=$(sed -E 's/.*color: *"([^"]+)".*/\1/' <<<"$line")
  desc=$(sed -E 's/.*description: *"([^"]*)".*/\1/' <<<"$line")
  gh label create "$name" --repo "$repo" --color "$color" --description "$desc" --force >/dev/null
  echo "✓ $name"
done
