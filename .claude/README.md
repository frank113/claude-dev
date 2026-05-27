# .claude/

This directory contains the project-scoped Claude Code configuration for this submodule.
See `README.claude.md` at the repo root for the full layering model and submodule setup.

## Skills

Skills are invoked as `/skill-name`. Each skill lives in its own folder under `.claude/skills/`
with `SKILL.md` as the entrypoint. The invocation name is the directory name.

### The core mental model: ask "who owns this problem?"

Before deciding where a skill lives, answer one question:

> "Is this skill solving a problem about the _development environment_, a _specific project_, or a _personal workflow_?"

| Problem owner | Skill tier | Where it lives |
|---------------|------------|----------------|
| The dev environment (Claude config itself) | Submodule | `.claude/skills/` in this repo |
| A specific project's domain | Project | `.claude/skills/` in the consuming repo |
| Personal habits and preferences | User | `~/.claude/skills/` via dotfiles |
| One machine only, not worth committing | Local | `.claude/skills/` + gitignored |

Apply this test to any new skill before writing a single line:

- `/start-repo` — sets up Claude config files → environment problem → submodule
- `/deploy-staging` — deploys a specific app → project problem → consuming repo
- `/my-preferred-pr-format` — your personal PR style → personal problem → dotfiles

### Tier 1 — Submodule skills (this repo)

Skills that operate on the Claude configuration layer itself. They are environment-maintenance
tools, not business-logic tools. Any repo using this submodule should benefit from them equally.

Canonical examples:

- `/start-repo` — scaffold local config files for a new environment
- `/audit-permissions` — review what the allow/deny lists permit
- `/update-rules` — apply a new rules template to a project

What does NOT belong here: a skill that references your app's stack, deployment target,
database schema, or domain language. That coupling means it belongs one tier lower, in
the consuming repo.

Auto-load requirement: submodule skills are not auto-loaded. The consuming repo must
declare the submodule path in its own `.claude/settings.json`:

```json
{
  "additionalDirectories": [".claude-config"]
}
```

Without this, the skills exist on disk but are invisible to Claude.

### Tier 2 — Project skills (consuming repo)

Skills that encode knowledge about one specific project — its tech stack, deployment
pipeline, test conventions, or domain vocabulary. Committed to that project's repo and
travel with it, but never touch this submodule.

Canonical examples:

- `/deploy-staging` — deploy this app's staging environment
- `/gen-migration` — generate a database migration scaffold for this schema
- `/summarize-pr` — write a PR description using this team's template

Structure in the consuming repo:

```text
my-project/
  .claude-config/              ← this submodule (read-only from my-project's perspective)
  .claude/
    settings.json              ← must include additionalDirectories for submodule skills
    skills/
      deploy-staging/          ← project skill: lives here, committed to my-project
        SKILL.md
      gen-migration/
        SKILL.md
        migration.template.sql ← sibling templates follow the same pattern as start-repo
```

Key rule: never add a project-specific skill to this submodule. If you find yourself
writing a skill that references a specific repo, team, or app, stop — it belongs in
that project's `.claude/skills/`, not here.

### Tier 3 — User skills (dotfiles)

Skills that reflect personal workflow preferences — how you like to write commit messages,
your preferred code review checklist, your debugging ritual. Invisible to teammates and CI,
and they apply across every project you open.

Canonical examples:

- `/my-standup` — draft a standup update from recent git activity
- `/review-checklist` — run your personal code review checklist
- `/explain-diff` — explain the current git diff in plain English

User skills cannot live in any project repo. The standard pattern is a personal dotfiles
repo that manages `~/.claude/` via symlinks:

```text
~/dotfiles/
  claude/
    skills/
      my-standup/
        SKILL.md
      review-checklist/
        SKILL.md
```

Symlink once per machine:

```bash
ln -s ~/dotfiles/claude/skills ~/.claude/skills
```

`~/.claude/skills/` is then tracked in your dotfiles repo and available in every Claude
Code session on every machine you clone it to. New machines get your full skill set
with a single `git clone` + symlink.

### Tier 4 — Local skills (gitignored, one machine only)

Throwaway or experimental skills, or skills that contain machine-specific paths or
credentials that must never be committed.

Add the skill folder to the consuming repo's `.gitignore`:

```text
.claude/skills/my-experiment/
```

Local skills are auto-loaded (they're at the project root `.claude/skills/`) but are
never committed anywhere. Use sparingly — if a skill is worth keeping, promote it to
one of the committed tiers above.

### Precedence when names collide

If two tiers define a skill with the same name, the higher tier wins:

```text
User  >  Project  >  Submodule
```

This means you can override a submodule skill in a specific project, or override a
project skill with a personal version, without modifying the lower tier.

### Decision tree for placing a new skill

```text
Is this skill useful in EVERY repo that uses this submodule?
  ├── Yes → Does it operate on Claude config/environment?
  │           ├── Yes → Submodule (.claude/skills/ here)
  │           └── No  → Reconsider; it's probably project-specific
  └── No  → Is it specific to one project's domain?
              ├── Yes → Project (consuming repo's .claude/skills/)
              └── No  → Is it a personal preference?
                          ├── Yes → User (~/.claude/skills/ via dotfiles)
                          └── No  → Local (gitignored in consuming repo)
```

### All four tiers at a glance

| Tier | Location | Version controlled where | Auto-loaded |
|------|----------|--------------------------|-------------|
| Submodule | `<submodule>/.claude/skills/` | This repo | No — needs `additionalDirectories` |
| Project | `<repo>/.claude/skills/` | That consuming repo | Yes |
| User | `~/.claude/skills/` | Personal dotfiles repo | Yes |
| Local | `<repo>/.claude/skills/` + gitignored | Nowhere | Yes |

## Rules

Rules files in `.claude/rules/` are committed and shared. Files without a `paths:`
frontmatter load unconditionally at session start. Files with one load only when Claude
opens a matching file (lazy-loaded).

```markdown
---
paths:
  - "**/*.tf"
---
Terraform-specific instructions here.
```

## Settings

| File | Scope | Purpose |
|------|-------|---------|
| `settings.json` | PROJECT | Shared permissions, hooks, env vars — committed |
| `settings.local.json` | LOCAL | Machine-specific overrides — gitignored, never committed |
