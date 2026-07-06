#!/usr/bin/env bash
set -euo pipefail

## Installs all claude-dev dotfiles to ~/.claude/.
## Each sub-script can also be run independently from scripts/.

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "==> settings.json → ~/.claude/settings.json"
bash "$SCRIPTS_DIR/install_settings.sh"

echo ""
echo "==> skills → ~/.claude/skills/"
bash "$SCRIPTS_DIR/install_skills.sh"

echo ""
echo "==> statusline.sh + settings.json statusLine patch"
bash "$SCRIPTS_DIR/install_statusline.sh"

echo ""
echo "==> CLAUDE.md → ~/.claude/CLAUDE.md"
bash "$SCRIPTS_DIR/install_claude_md.sh"

echo ""
echo "==> agents → ~/.claude/agents"
bash "$SCRIPTS_DIR/install_agents.sh"

echo ""
echo "All steps complete. ~/.claude is up to date."
