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
4. The smallest necessary change

By default, make the smallest correct change that satisfies the request.
Unless the task explicitly requires it, do not change existing behavior, public APIs, data formats, compatibility, project structure, or external interfaces.

For non-trivial tasks, read the relevant files, tests, error messages, and project documentation before making changes.
If key information is missing and prevents correct implementation, ask concise, focused questions.
If an ambiguity does not block implementation, choose the simplest reasonable interpretation, state the assumption, and continue.

For simple, clear, low-risk changes, you may proceed directly.

## Goals and Verification

After completing changes, use an independent sub-agent to review the changes. Only fix issues that are clearly valid and have medium or higher severity; do not make extra changes for low-severity issues, subjective style preferences, or unrelated suggestions, and mention them in the final response only when necessary.

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
