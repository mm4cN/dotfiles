---
name: code-review
description: Review a change for correctness, regressions, safety, compatibility, and maintainability, prioritizing actionable findings over summaries.
---

# Code Review

Use this skill when reviewing a patch, branch, commit, pull request, or implementation result.

## Goal

Find concrete defects and meaningful risks. A review is not a diff summary and not a style contest.

## Review Order

Review in this order:

1. correctness;
2. regressions and edge cases;
3. data loss, security, concurrency, resource lifetime, and failure handling;
4. API and compatibility impact;
5. missing or insufficient tests;
6. maintainability problems that have a concrete consequence;
7. style only when it affects correctness or project conventions.

## Workflow

1. Understand the intended behavior.
2. Inspect the complete relevant diff and nearby code paths.
3. Trace changed inputs, outputs, state transitions, and error paths.
4. Check assumptions against callers, tests, configuration, and interfaces.
5. Look for behavior that changed unintentionally.
6. Check whether tests prove the important contracts.
7. Report only findings you can explain and support.

## Finding Format

For each finding include:

- severity;
- file and location;
- the concrete problem;
- the condition under which it occurs;
- the consequence;
- a concise remediation direction when useful.

## Rules

- Do not manufacture findings to appear thorough.
- Do not report speculative problems without a plausible execution path.
- Do not nitpick formatting unless the project enforces it or readability materially suffers.
- Prefer one precise finding over several vague variants of the same issue.
- Distinguish bugs from optional improvements.
- If no material issue is found, say so plainly.

For severity guidance, read `references/severity.md`.
