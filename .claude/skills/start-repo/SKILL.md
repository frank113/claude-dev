---
description: Scaffold the gitignored local config files (CLAUDE.local.md and .claude/settings.local.json) with dummy placeholders for a new environment
---

You are setting up the LOCAL-scope configuration files for this repository.
These files are gitignored and machine-specific — they will NOT be committed.

The templates for both files live alongside this skill:
- `.claude/skills/start-repo/CLAUDE.local.template.md`
- `.claude/skills/start-repo/settings.local.template.json`

Follow these steps exactly:

## Step 1 — Check what already exists

Before creating anything, check whether each target file already exists:
- `CLAUDE.local.md` in the project root
- `.claude/settings.local.json`

If a file already exists, skip creating it and tell the user.

## Step 2 — Create CLAUDE.local.md (if missing)

Read `.claude/skills/start-repo/CLAUDE.local.template.md` and write its contents
verbatim to `CLAUDE.local.md` at the project root.

## Step 3 — Create .claude/settings.local.json (if missing)

Read `.claude/skills/start-repo/settings.local.template.json` and write its contents
verbatim to `.claude/settings.local.json`.

## Step 4 — Confirm

Tell the user which files were created and which were skipped (already existed).
Remind them that both files are gitignored and safe to fill in with real values.
