# skills

- **URL:** https://github.com/mattpocock/skills
- **Owner:** mattpocock
- **Language:** Markdown / Shell
- **Stars:** ~3k
- **Date Added:** 2026-04-29
- **Category:** Agent Frameworks & Design

## Summary

`mattpocock/skills` is a curated library of composable slash-command skills for coding agents (Claude Code, GitHub Copilot, Codex, and others) rooted in decades of software-engineering fundamentals. Each skill is a small, self-contained `SKILL.md` prompt file that encodes a repeatable practice — from requirement grilling and TDD to codebase architecture review — and can be installed in seconds via `npx skills@latest add mattpocock/skills`. The collection is intentionally minimal and hackable, designed to be adapted to any project rather than owning the entire development process.

## Key Features

- `/grill-me` and `/grill-with-docs` — pre-work alignment sessions that surface ambiguity and build a shared domain language (`CONTEXT.md`) before coding starts
- `/tdd` — structured red-green-refactor loop that keeps coding agents anchored to failing tests, dramatically reducing hallucinated code
- `/improve-codebase-architecture` and `/zoom-out` — design-focused skills that fight software entropy by prompting agents to reason about system structure
- `/diagnose` — disciplined bug-isolation loop (reproduce → minimise → hypothesise → instrument → fix → regression-test)
- `/triage`, `/to-prd`, `/to-issues` — issue-tracker integration for GitHub, Linear, or local files with label-aware triage state machines

## Relevance to AI-Driven Development

This repo directly addresses the core failure modes of agentic coding (misalignment, verbosity, unreliable code, architectural decay) with small, model-agnostic skill prompts that reinforce engineering fundamentals. It is a practical reference for teams building or curating their own agent skill libraries, and its composable design pattern aligns closely with the agentic AI workflow philosophy documented in this toolkit.
