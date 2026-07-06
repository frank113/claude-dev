# claude-dev

A version-controlled Claude Code configuration template, designed to be the source of truth for all settings in my system configuration. The pattern of a version-controlled configuration layer and propagating it within a system.

## Repository Features

This repository features the following information:

+ Frank's Claude
  - Rules
  - Skills
  - Settings
+ User `CLAUDE.md` file
+ Scripts to sync these settings to the user's settings in `~/.claude`
+ Conventions for how Frank uses his configurations such as `*.local.md` files.

## Goals

The goal of this repository is three-fold:

1. To version-control my Claude settings for reference when working in other environments
2. To provide a minimally-redacted view of how an engineer actually uses Claude to enhance his workflow
3. To rapidly iterate with Claude configurations to better use agentic AI.

## Configuration Design

The configurations managed in this repository respects Anthropic's settings hierarchy. As a reminder the following taxonomy is applied:

1. Managed settings: Stored at `managed-settings.json`, cannot be overwritten
2. User settings: Global settings set by the user in `~/.claude/settings.json`. This is the highest level of permissions we will set in this repository.
3. Project settings: Located in a repository's `.claude/settings.json`. Version-controlled
4. Project-local settings: Settings specific to a user in a project. Stored in `.claude/settings.local.json`. Not committed.

In this repository we will store and promote tier 2, or user settings via the `scripts/` folder.

## Philosophy

When creating these settings I adhered to the following guiding principles.

### 1. Allow lists define an agent's powers, deny lists form an agent's guardrails

When configuring allow and deny lists we can think of each list as:

+ Allow lists: The explicit capabilities of what an agent can do. This list defines permissions that every agent should do without human intervention. As such we must keep this list intentionally scoped
+ Deny lists: Hard boundaries that the agent can never cross. This list should be expansive to cover corner cases to prevent leakage.

### 2. Determinism is a function of configuration

LLMs hallucinate and sometimes disregard stated preferences. The structure of the features in this repository are partially guided by the question "How critical is it that I have determinism?". 

Hooks are entirely deterministic and must happen at certain steps. The hooks section is intentionally light at the **user** level as defining truly global deterministic behavior shows that very few things need to happen absolutely every time.

Skills can be deterministic in their invocations but inconsistent in their results. Skills are defined as reproducible processes that I control while accepting that the results can be inconsistent.

Agents are used as opinionated compositions of skills and tools. As subagents are typically spawned by the primary Claude session agents are used to respond to the statement "whenever you need to do X, do it in Y way."

### 3. Define what global means

This repository represents the settings that I keep in my **user** Claude settings at `~/.claude/`. Therefore these settings apply to every repository and every Claude invocation. The permissions are thin as to globally apply. More granular permissions, such as custom agents I use when writing my personal website or when managing terraform, are defined in this specific repositories.

### 4. Style Matters

To make best use of Claude it must write code that mimics my personal style and taste. The `rules/` directory is an ever-evolving codification of those standards as I notice them in my own work. Defining style and taste guides informed by my decade of academic and industry software experience is a rewarding exercise.

## Commentary

This section will serve as a running commentary of how I came to arrive at my rules and credits to those who inspired certain configurations.

+ `PreToolUse` Deletion Hook: Taken directly from [Marco Lancini](https://blog.marcolancini.it/2026/blog-my-claude-code-setup/). Interesting guardrail that will be eternally useful as Claude becomes more agentic.
+ `General` section of `CLAUDE.md`: Taken from [Freek Van der Herten](https://freek.dev/3026-my-claude-code-setup). His observation of model syncophancy is an interesting guardrail that I found myself prompting against.
