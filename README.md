# claude-dev

A version-controlled Claude Code configuration template, designed to be the source of truth for all settings in my system configuration. The pattern of a version-controlled configuration layer and propgating it within a system.

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

**1. Allow lists define an agent's powers, deny lists form an agent's guardrails**

When configuring allow and deny lists we can think of 

**2. Skills are reusable procedures, agents are reusable personas**

**3. Define what global means**

**4. Style Matters**

## Commentary

This section will serve as a running commentary of how I came to arrive at my rules and credits to those who inspired certain configurations.

+ `PreToolUse` Deletion Hook: Taken directly from [Marco Lancini](https://blog.marcolancini.it/2026/blog-my-claude-code-setup/). Interesting guardrail that will be eternally useful as Claude becomes more agentic.
