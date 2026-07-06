#!/usr/bin/env bash
set -euo pipefail

## Installs CLAUDE.md from this repo as the user-global ~/.claude/CLAUDE.md.
## Makes the repo the single source of truth for global Claude instructions.

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.claude/agents"
DEST_AGENTS="$HOME/.claude/agents"

echo "Installing agents..."

cp -r "$SRC" "$DEST"
echo "  Done: $DEST"