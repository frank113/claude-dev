---
paths:
  - "**/*.md"
---

# Markdownlint Rules

When writing or editing markdown files, comply with markdownlint rules with the following exception:

- MD013 (line length) — ignored. Do not wrap lines or flag line length.

All other markdownlint rules are enforced. Common ones to observe:

- MD012 — no multiple consecutive blank lines
- MD032 — lists must be surrounded by blank lines
- MD040 — fenced code blocks must declare a language
- MD041 — first line of a file must be a top-level heading

MD060 (table column alignment) is also disabled — it requires a formatter to satisfy and cannot be maintained by hand.

Fix any violations in content you write. Do not introduce new violations when editing existing files.
