# Project Context

- **Owner:** kdcllc
- **Project:** Documentation-first toolkit for agentic AI developer workflows, setup guides, and reusable Copilot/Squad patterns
- **Stack:** Markdown, Bash, GitHub CLI, GitHub Actions, VS Code/Copilot config, Squad templates
- **Created:** 2026-04-19T20:33:51Z

## Learnings

<!-- Append new learnings below. Each entry is something lasting about the project. -->

### Content Intake System (2026-06-27)
- **Architecture:** Issue templates (`content:article`, `content:repo`) → `content-intake.yml` workflow → Copilot agent → PR. No custom scripts needed for MVP.
- **Repo structure:** `articles/` and `repos/` directories with `.template.md` and `index.md`. Existing `articles.md` and `code.md` remain manually curated — the automated system is additive.
- **Routing:** Content intake labels bypass normal squad triage and route directly to `squad:copilot`. The `content-intake.yml` workflow handles slug generation, instruction formatting, and Copilot agent assignment.
- **Labels:** `content:article` and `content:repo` are synced via `sync-squad-labels.yml`. Issue templates auto-apply them.
- **Key files:** `.github/ISSUE_TEMPLATE/content-article.yml`, `.github/ISSUE_TEMPLATE/content-repo.yml`, `.github/workflows/content-intake.yml`, `articles/.template.md`, `repos/.template.md`
- **User preference:** kdcllc wants low-friction intake — paste URL, pick category, submit. Everything else is automated.
