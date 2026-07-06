#!/usr/bin/env bash
set -euo pipefail

## Wipes ~/.claude/skills/ and replaces it with this repo's .claude/skills/.
## A timestamped backup of any existing skills is made before removal.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_SKILLS="$REPO_ROOT/.claude/skills"
DEST_SKILLS="$HOME/.claude/skills"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing skills..."

if [[ -d "$DEST_SKILLS" ]]; then
    mkdir -p "$BACKUP_DIR"
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp -r "$DEST_SKILLS" "$BACKUP_DIR/skills.${timestamp}.bak"
    echo "  Backed up: $BACKUP_DIR/skills.${timestamp}.bak"
    rm -rf "$DEST_SKILLS"
fi

cp -r "$SRC_SKILLS" "$DEST_SKILLS"
echo "  Done: $DEST_SKILLS"
