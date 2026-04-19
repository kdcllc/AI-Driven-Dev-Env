# Project Context

- **Owner:** kdcllc
- **Project:** Documentation-first toolkit for agentic AI developer workflows, setup guides, and reusable Copilot/Squad patterns
- **Stack:** Markdown, Bash, GitHub CLI, GitHub Actions, VS Code/Copilot config, Squad templates
- **Created:** 2026-04-19T20:33:51Z

## Learnings

<!-- Append new learnings below. Each entry is something lasting about the project. -->

### 2026-04-19: Content Ingestion Automation System

**Context:** User wants automatic article/repo submission when discovering content on devblogs.microsoft.com or GitHub.

**Implementation:** GitHub Issue Forms + Copilot coding agent approach.
- Issue templates: `.github/ISSUE_TEMPLATE/content-article.yml` and `content-repo.yml`
- Workflow: `.github/workflows/content-intake.yml` routes to `squad:copilot`
- Copilot agent creates entries in `articles/` and `repos/` folders, updates indexes
- PR review assigned to Hermes (Technical Writer)

**Key Files:**
- `.github/ISSUE_TEMPLATE/content-{article|repo}.yml` — Submission forms
- `.github/workflows/content-intake.yml` — Routes to copilot
- `articles/{index.md, README.md, .template.md}` — Article structure
- `repos/{index.md, README.md, .template.md}` — Repo structure

**Design Philosophy:**
- Simple over complex: Copilot routing beats Python scripts + LLM APIs
- No secrets, no dependencies
- Leverage existing Squad infrastructure
- Copilot's web_fetch handles content fetching

**Workflow:**
1. User creates issue with URL and category
2. Workflow parses issue, posts instructions comment
3. Copilot agent assigned (`squad:copilot`)
4. Copilot fetches, summarizes, creates file, updates index
5. Copilot commits and creates PR
6. Hermes reviews PR before merge

### 2026-04-19: Content Ingestion Automation System

**Context:** User wants automatic article/repo submission when discovering content on devblogs.microsoft.com or GitHub.

**Decision:** Use GitHub Issue Forms + Copilot coding agent approach (already implemented by Leela).
- Issue templates: `.github/ISSUE_TEMPLATE/content-article.yml` and `content-repo.yml`
- Workflow: `.github/workflows/content-intake.yml` routes to `squad:copilot`
- Copilot agent manually creates entries in `articles/` and `repos/` folders

**Rationale:**
- Simpler than Python scripts + LLM API dependencies
- No secrets management (OPENAI_API_KEY, ANTHROPIC_API_KEY)
- Leverages existing Squad infrastructure
- Copilot has web_fetch and can access articles directly
- More flexible — Copilot can adapt to different content formats

**Alternative considered:** Fully automated Python pipeline with web scraping, LLM summarization, and PR creation.
- Rejected: Over-engineered for this use case
- Requires API keys and dependency management
- Harder to maintain and debug

**Files:**
- `.github/ISSUE_TEMPLATE/content-article.yml` — Article submission form
- `.github/ISSUE_TEMPLATE/content-repo.yml` — Repo submission form
- `.github/workflows/content-intake.yml` — Routes to copilot agent
- `articles/` and `repos/` folders with index files and templates
- `articles/README.md` and `repos/README.md` — Documentation

**Workflow:**
1. User creates issue with URL and category
2. Workflow parses issue, posts instructions comment
3. Copilot agent is assigned (`squad:copilot`)
4. Copilot fetches content, summarizes, creates file, updates index
5. Copilot commits and creates PR
6. Hermes reviews PR

### 2026-04-19: Content Intake Needs Explicit Copilot Setup

- Keep `@copilot` in `.squad/team.md` so roster-driven label sync can create `squad:copilot`.
- Do not put `squad:copilot` directly in content issue templates; let the workflow add it after checking repo setup.
- `COPILOT_ASSIGN_TOKEN` is optional for issue intake creation, but required for automatic Copilot coding-agent assignment. Without it, the workflow should say so and leave manual next steps.
