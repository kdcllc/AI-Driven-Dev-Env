# Squad Team

> AI-DrivenDevEnv

## Coordinator

| Name | Role | Notes |
|------|------|-------|
| Squad | Coordinator | Routes work, enforces handoffs and reviewer gates. |

## Members

| Name | Role | Charter | Status |
|------|------|---------|--------|
| Leela | Lead | `.squad/agents/leela/charter.md` | Active |
| Farnsworth | AI/Context Engineer | `.squad/agents/farnsworth/charter.md` | Active |
| Hermes | Technical Writer | `.squad/agents/hermes/charter.md` | Active |
| Amy | Platform Engineer | `.squad/agents/amy/charter.md` | Active |
| Bender | DevOps & Automation Engineer | `.squad/agents/bender/charter.md` | Active |
| Scribe | Scribe | `.squad/agents/scribe/charter.md` | Active |
| Ralph | Work Monitor | `.squad/agents/ralph/charter.md` | Active |

## Coding Agent

<!-- copilot-auto-assign: false -->

| Name | Role | Charter | Status |
|------|------|---------|--------|
| @copilot | Coding Agent | — | 🤖 Coding Agent |

### Capabilities

**🟢 Good fit — auto-route when enabled:**
- Bug fixes with clear reproduction steps
- Test coverage, lint, and formatting cleanup
- Small isolated features with clear specs
- Boilerplate or scaffolding work
- Documentation updates with clear scope

**🟡 Needs review — route to @copilot but review the PR:**
- Medium features with clear acceptance criteria
- Refactoring with existing test coverage
- Workflow or automation changes that stay inside established patterns

**🔴 Not suitable — route to a squad member instead:**
- Architecture or system design decisions
- Security-critical changes
- Ambiguous work that needs human clarification
- Multi-system changes that require coordination

## Project Context

- **Owner:** kdcllc
- **Project:** AI-DrivenDevEnv
- **Description:** Documentation-first toolkit for agentic AI developer workflows, setup guides, and reusable Copilot/Squad patterns.
- **Stack:** Markdown, Bash, GitHub CLI, GitHub Actions, VS Code/Copilot config, Squad templates
- **Created:** 2026-04-19
