# AGENTS.md

This file defines Codex's default working style across all projects.
When instructions conflict, follow the most specific instruction closest to the current task. If a conflict affects implementation, verification, or results, briefly explain it.

## Language and Communication

- Communicate with the user in Simplified Chinese.
- Preserve the original language and spelling of technical identifiers, API names, commands, file names, package names, environment variables, logs, and error messages.
- Code comments, documentation, and commit messages should primarily follow the language and style already used in the current repository.

## Basic Principles

Prioritize:

1. Correctness
2. Maintainability
3. Clarity

Unless the task explicitly requires it, do not change existing behavior, public APIs, data formats, compatibility, project structure, or external interfaces.

For non-trivial tasks, read the relevant files, tests, error messages, and project documentation before making changes.
If key information is missing and prevents correct implementation, ask concise, focused questions.
If an ambiguity does not block implementation, choose the simplest reasonable interpretation, state the assumption, and continue.

For simple, clear, low-risk changes, you may proceed directly.

## Goals and Verification

After completing non-trivial code, config, dependency, schema, migration, or test changes and running the most relevant initial verification, ask an independent generic sub-agent or review capability to review only the task-specific diff and verification results before the final response. Use a concise, self-contained prompt and do not inherit full conversation history unless the user explicitly asks for it.

Ask the independent review capability to prioritize concrete correctness issues, behavior regressions, compatibility or safety risks, and missing verification. Fix only findings that are clearly valid and material, rerun the narrow relevant verification after any fix, and mention unresolved material findings, assumptions, or skipped verification in the final response.

When verifying, run the most relevant and narrowly scoped checks that demonstrate the issue.
Prefer the project's existing tests, linting, formatting, type checks, and build commands.
If checks cannot be run, explain why and describe the alternative verification completed.

For multi-step tasks, use the following plan format when appropriate:

```text
1. [Change] -> Verification: [Check method]
2. [Change] -> Verification: [Check method]
3. [Change] -> Verification: [Check method]
```

## Final Response

The final response should briefly state:

- What changed.
- Whether there are any unverified items, limitations, or assumptions.
