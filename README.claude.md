# claude-dev

A version-controlled Claude Code configuration template, designed to be used as a **git submodule** across personal and professional development environments.


## Configuration Layering Model

Claude Code loads configuration from four scopes in priority order. Higher scopes override lower ones where settings conflict; all CLAUDE.md files are **concatenated** (not overridden).

```text
┌─────────────────────────────────────────────────────────────┐
│  MANAGED   IT/org-deployed policy — cannot be overridden    │
├─────────────────────────────────────────────────────────────┤
│  USER      Personal settings across all projects            │
├─────────────────────────────────────────────────────────────┤
│  PROJECT   Team settings — committed to git                 │
├─────────────────────────────────────────────────────────────┤
│  LOCAL     Machine-specific overrides — never committed     │
└─────────────────────────────────────────────────────────────┘
```


## File Inventory

### In This Submodule (Committed to Git)

These files are shared across all environments that consume this submodule.

| File | Scope | Purpose |
|------|-------|---------|
| `CLAUDE.md` | **PROJECT** | Primary shared instructions — coding standards, conventions, context Claude reads on every session |
| `.claude/settings.json` | **PROJECT** | Shared permissions (allow/deny lists), hooks, env vars, announcements |
| `.claude/rules/*.md` | **PROJECT** | Conditional instruction files; use `paths:` frontmatter to scope rules to specific file patterns |
| `.claude/skills/_template/SKILL.md` | **PROJECT** | Annotated template; copy the `_template/` folder to create a new submodule skill |
| `.claude/skills/start-repo/SKILL.md` | **PROJECT** | Skill (`/start-repo`) that scaffolds local dummy config files in a new environment |
| `.gitignore` | **PROJECT** | Ensures local-only files are never committed |
| `README.claude.md` | **PROJECT** | This file |

### Created Locally — Never Committed

These files are gitignored and machine- or user-specific. Create them in your local checkout to extend or override the shared config.

| File | Scope | Purpose |
|------|-------|---------|
| `CLAUDE.local.md` | **LOCAL** | Personal project-level additions to `CLAUDE.md` (credentials, local paths, personal workflow notes) |
| `.claude/settings.local.json` | **LOCAL** | Machine-specific settings overrides (e.g. personal allow-list additions, local env vars) |

### Outside This Repo — Global User Config

These live in your home directory and apply to **all** Claude Code sessions regardless of project. They are never part of any repo.

| File | Scope | Purpose |
|------|-------|---------|
| `~/.claude/CLAUDE.md` | **USER** | Personal instructions applied globally to every project |
| `~/.claude/settings.json` | **USER** | Personal settings applied globally (keybindings, preferred defaults) |
| `~/.claude/rules/*.md` | **USER** | Personal conditional rules applied globally |
| `~/.claude/keybindings.json` | **USER** | Custom keyboard shortcut bindings |

### Managed / Enterprise (If Applicable)

Deployed by IT or a platform team. Takes highest priority and cannot be overridden locally.

| File | Scope | Platform | Purpose |
|------|-------|----------|---------|
| `/Library/Application Support/ClaudeCode/CLAUDE.md` | **MANAGED** | macOS | Org-wide instructions |
| `/etc/claude-code/CLAUDE.md` | **MANAGED** | Linux/WSL | Org-wide instructions |
| `managed-settings.json` | **MANAGED** | All | Org-wide settings policy |
| `managed-mcp.json` | **MANAGED** | All | Org-wide MCP server allowlist/denylist |


## Using This Repo as a Submodule

```bash
# Add to a new project
git submodule add https://github.com/<you>/claude-dev .claude-config

# Pull latest config into an existing checkout
git submodule update --remote --merge
```

Then import the shared `CLAUDE.md` from your project's own `CLAUDE.md`:

```markdown
# In your project's CLAUDE.md
@.claude-config/CLAUDE.md
```


## Skills Architecture

Skills are invoked as `/skill-name`. The invocation name is the **directory name**, not the filename. The entrypoint file must be named `SKILL.md`.

There are three tiers, each with a different home:

```text
TIER          LOCATION                               WHEN TO USE
----          --------                               -----------
Submodule     <submodule>/.claude/skills/<name>/     Shared across every repo using this submodule
Project       <repo>/.claude/skills/<name>/          Specific to one repo; committed to that repo
User          ~/.claude/skills/<name>/               Personal; never committed to any repo
```

### Submodule skills (this repo)

Skills here are available in every project that includes this submodule. They are **not auto-loaded** — the consuming repo must register the submodule path. Add this to the consuming repo's `.claude/settings.json`:

```json
{
  "additionalDirectories": [".claude-config"]
}
```

Or pass it at the command line: `claude --add-dir .claude-config`

### Project-specific skills (consuming repo)

Skills that only make sense for one project live in that project's own `.claude/skills/` directory and are committed to that repo — never to this submodule.

```text
my-project/
  .claude-config/               ← this submodule
  .claude/
    skills/
      deploy-staging/           ← project-specific, committed to my-project only
        SKILL.md
    settings.json               ← registers .claude-config via additionalDirectories
```

### User-level skills (personal, never committed)

Skills you want everywhere but do not want in any repo go in `~/.claude/skills/`. These are invisible to teammates and CI.

### Precedence when names collide

If two tiers define a skill with the same name, the higher tier wins:

```text
User  >  Project  >  Submodule
```


## Adding Local Overrides

### Extending instructions (CLAUDE.local.md)

Create `CLAUDE.local.md` at the project root. Claude loads it automatically alongside `CLAUDE.md`. Use it for anything that should **not** be committed: personal notes, local service URLs, private context.

```markdown
# CLAUDE.local.md  (gitignored)
- Local DB is at postgres://localhost:5432/mydb_dev
- I prefer running tests with `pytest -x -v`
```

### Extending settings (.claude/settings.local.json)

Create `.claude/settings.local.json` to add machine-specific permissions or env vars. These **merge** with (and can extend) the committed settings but **cannot override** managed-scope denies.

```json
// .claude/settings.local.json  (gitignored)
{
  "permissions": {
    "allow": ["Bash(docker compose up)"]
  },
  "env": {
    "DEBUG": "true"
  }
}
```


## Adding Path-Scoped Rules (.claude/rules/)

Rules files in `.claude/rules/` are committed and shared. Files without a `paths:` frontmatter load unconditionally; files with one load only when Claude opens matching files.

```markdown
---
paths:
  - "**/*.tf"

# Terraform Rules
Always run `terraform validate` before proposing a plan.
Never suggest `terraform destroy` without an explicit user request.
```


## Quick Reference: Useful Slash Commands

A curated subset of commands worth knowing. Run `/help` for the full list.

| Command | Scope | What it does |
|---------|-------|--------------|
| `/btw <question>` | **SESSION** | Ask a side question without adding it to conversation history. Appears in a dismissible overlay; reuses the prompt cache so it's low-cost. No tool access — answers from current context only. |
| `/desktop` | **SESSION** | Teleport the current CLI session into the Claude Code Desktop app (macOS/Windows). Alias: `/app`. |
| `/compact [instructions]` | **SESSION** | Summarize conversation history to free up context window. Pass optional instructions to control what gets preserved. |
| `/memory` | **SESSION** | Edit CLAUDE.md and auto-memory entries interactively. |
| `/permissions` | **SESSION** | View or update tool allow/deny lists mid-session. Alias: `/allowed-tools`. |
| `/diff` | **SESSION** | Open an interactive diff viewer showing all uncommitted changes. |
| `/rewind` | **SESSION** | Roll back conversation and code to a prior checkpoint. Alias: `/checkpoint`. |
| `/doctor` | **GLOBAL** | Diagnose your Claude Code installation — checks config, auth, and settings validity. |
| `/model [model]` | **SESSION** | Switch the active model without starting a new session. |
| `/init` | **PROJECT** | Scaffold a `CLAUDE.md` for a new project from scratch. |

### Keyboard Shortcuts (Shown as Tips During Sessions)

| Shortcut | What it does |
|----------|--------------|
| `Tab` | Accept inline prompt suggestion |
| `Ctrl+O` | Toggle verbose output (shows detailed tool usage) |
| `Shift+Tab` / `Alt+M` | Cycle through permission modes |
| `Option+P` / `Alt+P` | Switch model without clearing the current prompt |
| `Esc Esc` | Rewind or summarize the conversation |


## What to Gitignore

The following are already covered by `.gitignore` in this repo:

```text
CLAUDE.local.md
.claude/settings.local.json
```
