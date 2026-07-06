#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.claude/agents"
DEST_AGENTS="$HOME/.claude/agents"

echo "Installing agents..."

cp -r "$SRC" "$DEST_AGENTS"
echo "  Done: $DEST_AGENTS"