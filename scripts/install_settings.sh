#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.claude/settings.json"
DEST="$HOME/.claude/settings.json"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing settings.json..."

cp "$SRC" "$DEST"
echo "  Done: $DEST"
