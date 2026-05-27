---
description: Template showing the structure of a Claude Code skill file
---

# Skill Template

<!--
  SKILL TEMPLATE
  ==============
  The SKILL INVOCATION NAME comes from the DIRECTORY NAME, not the filename.
  The entrypoint file must be named SKILL.md.

  SCOPE         LOCATION
  -------       --------
  Project       .claude/skills/<name>/SKILL.md          (committed to this repo)
  Submodule     <submodule>/.claude/skills/<name>/       (requires --add-dir, see below)
  User          ~/.claude/skills/<name>/SKILL.md         (personal, never committed)

  SUBMODULE NOTE
  --------------
  Skills in a submodule are NOT auto-loaded. The consuming repo must add the
  submodule path via --add-dir, either on the CLI or in settings.json:

    settings.json:
      { "additionalDirectories": [".claude-config"] }

    or at invocation:
      claude --add-dir .claude-config

  PROJECT-SPECIFIC SKILLS (not in submodule)
  -------------------------------------------
  Add them directly in the consuming repo's .claude/skills/ directory.
  They stay committed to that repo and are never pulled into this submodule.

  FOLDER STRUCTURE
  ----------------
  .claude/skills/
    my-skill/
      SKILL.md      ← required entrypoint (this file pattern)

  FRONTMATTER FIELDS
  ------------------
  description  (required)  One-line summary shown in /skills list.
  name         (optional)  Override the invocation name (default: directory name).

  BODY
  ----
  Everything below the frontmatter is the prompt Claude receives when the skill
  is invoked. Write it as direct instructions to Claude.

  TIPS
  ----
  - Keep the skill focused on one job.
  - Use $ARGUMENTS to capture text the user types after the command,
    e.g. `/my-skill some extra context` → $ARGUMENTS = "some extra context"
  - Skills can call other tools (Read, Write, Bash, etc.) just like normal prompts.
-->

<!-- Replace everything below with your skill's instructions -->

$ARGUMENTS
