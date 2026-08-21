---
name: exploration
description: Explore a codebase efficiently to answer a concrete question or locate the minimal implementation surface without loading irrelevant context.
---

# Exploration

Use this skill when the relevant code, configuration, ownership, or execution path is not yet known.

## Goal

Find enough evidence to act confidently while reading as little irrelevant material as possible.

## Workflow

1. Define the question exploration must answer.
2. Inspect repository guidance and top-level structure.
3. Search for exact symbols, filenames, commands, configuration keys, errors, or user-visible strings.
4. Follow references outward from the strongest match.
5. Read small relevant regions before opening entire files.
6. Trace callers, callees, tests, and configuration only as needed.
7. Stop when the implementation surface and dependencies are sufficiently understood.

## Search Strategy

Prefer:

- filename and directory search for known artifacts;
- exact text or symbol search for known identifiers;
- semantic exploration only after direct search stops producing useful evidence;
- existing tests to understand intended contracts;
- version-control history only when current code cannot explain intent or a regression.

## Rules

- Do not recursively read the repository without a concrete reason.
- Do not dump large files into context when a small range is sufficient.
- Do not inspect generated, vendored, cache, dependency, or build output unless directly relevant.
- Follow evidence, not directory order.
- Keep track of confirmed facts, open questions, and discarded hypotheses.
- Stop exploring once additional reads are unlikely to change the implementation decision.

For context discipline, read `references/context-discipline.md`.
