# Project Context

- **Owner:** kdcllc
- **Project:** Documentation-first toolkit for agentic AI developer workflows, setup guides, and reusable Copilot/Squad patterns
- **Stack:** Markdown, Bash, GitHub CLI, GitHub Actions, VS Code/Copilot config, Squad templates
- **Created:** 2026-04-19T20:33:51Z

## Learnings

<!-- Append new learnings below. Each entry is something lasting about the project. -->

## Session: Agentic AI Documentation & Squad Integration

**Date:** 2026-04-19 (current)

### Work Completed

- Updated `ai-coding.md` with stronger context engineering narrative (three-layer model, agentic AI focus, Squad introduction)
- Updated `.github/copilot-instructions.md` to acknowledge Squad, separate individual vs. team workflows, clarify when/where to find help
- Added `.squad/decisions/inbox/farnsworth-agentic-docs.md` explaining rationale

### Learnings

**Context engineering is the bottleneck, not models.** Most agentic failures come from incomplete project context, not model capability. This justifies the effort spent on `.github/copilot-instructions.md`, `.squad/`, and `ai-coding.md`.

**Explicit roles scale better than clever prompts.** When each agent (Farnsworth, Leela, Hermes, etc.) has a clear charter, handoffs are cleaner and context stays coherent. Squad's `.squad/agents/*/charter.md` files are the leverage point.

**Documentation is orchestration.** If this repo's architecture, conventions, and workflows are well-documented, any agent (Copilot, aider, Squad member) can self-orient. The docs ARE the interface.

### Pattern: Three Layers of Context Engineering

1. **Explicit Rules** — What the AI must/must not do
2. **Project Knowledge** — Docs, examples, patterns, error messages
3. **Validation & Feedback** — How to measure success, what to do if things break

This pattern is worth reusing in other projects.

### Pattern: Workflows as Metadata

Individual developers, Squad teams, and future orchestration tools all need to understand "what's the workflow?" Making workflows explicit in `.github/copilot-instructions.md` (and `.squad/routing.md` for Squad) reduces the need for bespoke guidance for each tool.

