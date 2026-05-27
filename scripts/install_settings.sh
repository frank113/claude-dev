#!/usr/bin/env bash
set -euo pipefail

## Deploys .claude/settings.json from this repo to ~/.claude/settings.local.json.
## The repo's settings.json is the authoritative source for global permissions and env vars.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.claude/settings.json"
DEST="$HOME/.claude/settings.local.json"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing settings.local.json..."

if [[ -f "$DEST" ]]; then
    mkdir -p "$BACKUP_DIR"
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$DEST" "$BACKUP_DIR/settings.local.json.${timestamp}.bak"
    echo "  Backed up: $BACKUP_DIR/settings.local.json.${timestamp}.bak"
fi

cp "$SRC" "$DEST"
echo "  Done: $DEST"
