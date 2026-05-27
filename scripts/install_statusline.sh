#!/usr/bin/env bash
set -euo pipefail

## Syncs statusline.sh → ~/.claude/statusline.sh and patches only the statusLine
## key in ~/.claude/settings.json using an absolute path. Requires jq.
## All other keys in settings.json (theme, effortLevel, etc.) are left untouched.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/statusline.sh"
DEST="$HOME/.claude/statusline.sh"
SETTINGS="$HOME/.claude/settings.json"
BACKUP_DIR="$HOME/.claude/backups"

echo "Installing statusline..."

## Back up and replace the statusline script
if [[ -f "$DEST" ]]; then
    mkdir -p "$BACKUP_DIR"
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$DEST" "$BACKUP_DIR/statusline.sh.${timestamp}.bak"
    echo "  Backed up: $BACKUP_DIR/statusline.sh.${timestamp}.bak"
fi
cp "$SRC" "$DEST"
echo "  Copied: $DEST"

## Patch only the statusLine key; create settings.json if it doesn't exist yet
if [[ -f "$SETTINGS" ]]; then
    mkdir -p "$BACKUP_DIR"
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$SETTINGS" "$BACKUP_DIR/settings.json.${timestamp}.bak"
    echo "  Backed up: $BACKUP_DIR/settings.json.${timestamp}.bak"
    tmp="$(mktemp)"
    jq '.statusLine = {"type": "command", "command": "bash ~/.claude/statusline.sh"}' "$SETTINGS" > "$tmp"
    mv "$tmp" "$SETTINGS"
    echo "  Patched statusLine in: $SETTINGS"
else
    printf '{"statusLine": {"type": "command", "command": "bash ~/.claude/statusline.sh"}}\n' > "$SETTINGS"
    echo "  Created: $SETTINGS"
fi

echo "  Done"
