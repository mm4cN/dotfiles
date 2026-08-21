---
name: implementation-planning
description: Produce an implementation plan grounded in the actual codebase, with concrete files, dependencies, risks, and verification steps.
---

# Implementation Planning

Use this skill before non-trivial implementation work, especially when the task spans multiple files, systems, or behaviors.

## Goal

Turn a request into a concrete, codebase-aware implementation plan. A plan should reduce uncertainty, not restate the task.

## Workflow

1. Restate the required observable behavior in precise terms.
2. Explore the code paths that currently implement or influence that behavior.
3. Identify relevant files, symbols, interfaces, tests, configuration, and external boundaries.
4. Determine the minimal set of changes required.
5. Identify dependencies and ordering constraints between changes.
6. Identify meaningful risks, unknowns, and compatibility concerns.
7. Define verification for each behavioral change.
8. Produce an ordered implementation plan.

## Plan Quality

Each implementation step should answer:

- what changes;
- where it changes;
- why it changes;
- what depends on it;
- how it will be verified.

Avoid vague steps such as "update logic" or "fix tests" when concrete symbols or files are known.

## Rules

- Inspect the codebase before proposing structural changes.
- Prefer existing abstractions and conventions.
- Separate confirmed facts from assumptions.
- Do not invent files, APIs, configuration, or architecture not found in the repository.
- Do not include optional cleanup unless it is required by the task.
- If an unknown blocks a reliable plan, make resolving that unknown an explicit first step.

## Output Shape

Use a short ordered plan. Include affected files or symbols when known, followed by verification and notable risks.

For deeper planning guidance, read `references/plan-quality.md`.
