# AGENTS.md

This file defines Codex's personal defaults across repositories.
Repository- and directory-specific guidance may refine these defaults.
Among applicable `AGENTS.md` rules, prefer the narrower scope. Mention only material conflicts that affect implementation, verification, or results.

## Communication

- Default to Simplified Chinese unless the user or deliverable requires another language.
- Preserve the original language and spelling of technical identifiers, API names, commands, file names, package names, environment variables, logs, and error messages.
- For repository content, follow nearby language, style, and conventions unless the user requests otherwise.

## Working Style

- Prioritize correctness, maintainability, clarity, and minimal scope.
- Make the smallest complete change that satisfies the request. Preserve behavior, public interfaces, data formats, compatibility, and project structure outside the requested scope; avoid unrelated refactors.
- Before material changes, inspect the necessary code, tests, errors, and project guidance. Respect existing user changes in the workspace.
- Ask only when missing information blocks safe and correct progress or would materially change the result. Otherwise, use the simplest reasonable interpretation and state only material assumptions.
- Use a plan only when it helps coordinate multi-step work; pair implementation steps with their verification without forcing a fixed format.

## Authorization

- For requests to answer, explain, review, diagnose, or report status, inspect the relevant materials and report the result. Do not modify files or external state unless the user also requests implementation.
- For requests to change, build, or fix, make the requested in-scope local changes and run relevant non-destructive verification without unnecessary confirmation.
- Require confirmation before destructive or difficult-to-reverse actions, external writes, or a material expansion of scope.

## Verification and Review

- Run the smallest relevant checks that verify the requested behavior, the change, and the main regression risks. Prefer the repository's existing tests, linting, formatting, type checks, and build commands.
- If relevant checks cannot be run, explain why and describe the alternative verification completed.
- Perform a focused self-review of task-specific changes before the final response. Request an independent, read-only review when the capability is available and the change has elevated risk, such as security, migrations, public APIs, compatibility, concurrency, dependencies, release configuration, cross-component behavior, or incomplete verification.
- Give an independent reviewer the task and acceptance criteria, relevant constraints, task-specific diff or files, verification results, and material assumptions. Fix only concrete and material findings, then rerun the relevant checks.

## Final Response

Lead with the outcome. For implementation tasks, summarize the changes and verification. Include material limitations, unverified items, and assumptions. Omit empty sections, repetition, and generic reassurance.
