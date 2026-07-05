#!/usr/bin/env bash
set -euo pipefail

## colors
R='\033[0m'

## Regular colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

## Bold
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_CYAN='\033[1;36m'

## Dim
DIM='\033[2m'

## Background colors
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'

## define variables
INPUT=$(cat)

jq_val() { echo "$INPUT" | jq -r "$1 // empty"; }

MODEL=$(jq_val '.model.display_name')
CWD=$(jq_val '.cwd')
DIR=$(basename "$CWD")
CTX_PCT=$(jq_val '.context_window.used_percentage')
RATE_5H=$(jq_val '.rate_limits.five_hour.used_percentage')
RATE_7D=$(jq_val '.rate_limits.seven_day.used_percentage')
VIM_MODE=$(jq_val '.vim.mode')
SESSION=$(jq_val '.session_name')
WORKTREE_BRANCH=$(jq_val '.worktree.branch')

## helper functions
## shorten model name
short_model() {
  echo "$1" \
    | sed 's/claude-//' \
    | sed 's/-\([0-9]\)-\([0-9]\)$/\-\1.\2/'
}

# Format a percentage with color thresholds (green < 50, yellow < 80, red >= 80)
color_pct() {
  local val="$1"
  local label="$2"
  if [ -z "$val" ]; then return; fi
  local pct
  pct=$(printf '%.0f' "$val")
  if   [ "$pct" -ge 80 ]; then color=$RED
  elif [ "$pct" -ge 50 ]; then color=$YELLOW
  else                          color=$GREEN
  fi
  printf "${color}${label}:${pct}%%${R}"
}

# Format epoch timestamp to HH:MM local time
fmt_epoch() {
  if [ -z "$1" ]; then return; fi
  date -r "$1" "+%H:%M" 2>/dev/null || date -d "@$1" "+%H:%M" 2>/dev/null
}

## Build the parts
PARTS=()

# Vim mode indicator
if [ -n "$VIM_MODE" ]; then
  case "$VIM_MODE" in
    NORMAL) PARTS+=("${BOLD}${YELLOW}[N]${R}") ;;
    INSERT) PARTS+=("${BOLD}${GREEN}[I]${R}") ;;
    *)      PARTS+=("${DIM}[${VIM_MODE}]${R}") ;;
  esac
fi

# Session name (if set)
# if [ -n "$SESSION" ]; then
#   PARTS+=("${CYAN}${SESSION}${R}")
# fi

## Build the session
# Directory
PARTS+=("${BLUE}${DIR}${R}")

# Worktree branch
if [ -n "$WORKTREE_BRANCH" ]; then
  PARTS+=("${MAGENTA}[${WORKTREE_BRANCH}]${R}")
fi

# Model
if [ -n "$MODEL" ]; then
  PARTS+=("${DIM}$(short_model "$MODEL")${R}")
fi

# Context window
if [ -n "$CTX_PCT" ]; then
  CTX_SEG=$(color_pct "$CTX_PCT" "ctx")
  [ -n "$CTX_SEG" ] && PARTS+=("$CTX_SEG")
fi

# Rate limits (subscribers only)
if [ -n "$RATE_5H" ]; then
  SEG=$(color_pct "$RATE_5H" "5h")
  [ -n "$SEG" ] && PARTS+=("$SEG")
fi

if [ -n "$RATE_7D" ]; then
  SEG=$(color_pct "$RATE_7D" "7d")
  [ -n "$SEG" ] && PARTS+=("$SEG")
fi

# ── Join with separator and print ──────────────────────────────
SEPARATOR="${DIM} | ${R}"
OUTPUT=""
for part in "${PARTS[@]}"; do
  if [ -z "$OUTPUT" ]; then
    OUTPUT="$part"
  else
    OUTPUT="${OUTPUT}${SEPARATOR}${part}"
  fi
done

printf "%b\n" "$OUTPUT"



