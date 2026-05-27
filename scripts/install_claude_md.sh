#!/usr/bin/env bash
set -euo pipefail

## Installs CLAUDE.md from this repo as the user-global ~/.claude/CLAUDE.md.
## Makes the repo the single source of truth for global Claude instructions.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/CLAUDE.md"
DEST="$HOME/.claude/CLAUDE.md"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing CLAUDE.md..."

if [[ -f "$DEST" ]]; then
    mkdir -p "$BACKUP_DIR"
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$DEST" "$BACKUP_DIR/CLAUDE.md.${timestamp}.bak"
    echo "  Backed up: $BACKUP_DIR/CLAUDE.md.${timestamp}.bak"
fi

cp "$SRC" "$DEST"
echo "  Done: $DEST"
