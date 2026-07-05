#!/usr/bin/env bash
set -euo pipefail

## Deploys .claude/settings.json from this repo to ~/.claude/settings.local.json.
## The repo's settings.json is the authoritative source for global permissions and env vars.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.claude/settings.json"
DEST="$HOME/.claude/settings.json"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing settings.local.json..."

cp "$SRC" "$DEST"
echo "  Done: $DEST"
