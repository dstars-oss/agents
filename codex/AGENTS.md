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

After completing non-trivial code, config, dependency, schema, migration, or test changes and running the most relevant initial verification, explicitly ask the `verifier` sub-agent to review and verify only the task-specific diff before the final response. If `verifier` is unavailable, use `/review` when available. Skip this for trivial documentation/text-only changes, very small low-risk edits, or when `verifier` and `/review` are unavailable; in those cases perform a focused self-review instead and mention it only when it affects confidence.

Ask `verifier` to use the task context to prioritize concrete correctness issues, behavior regressions, compatibility problems, safety risks, and missing or weak verification. Require findings to include severity, file/line references, rationale, and reproduction or verification steps when possible. "No findings" is an acceptable result.

Only fix verifier findings that are clearly valid and have material impact. Do not make extra changes for subjective style preferences, low-value suggestions, or unrelated suggestions. After fixing any accepted finding, rerun the relevant narrow verification and include unresolved material findings, assumptions, or skipped verification in the final response.

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
