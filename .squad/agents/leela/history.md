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

### Content Intake Review — Rejected (2026-06-27)
- **Verdict:** Rejected with three hard findings: (1) `COPILOT_ASSIGN_TOKEN` has no `|| secrets.GITHUB_TOKEN` fallback in `content-intake.yml` (unlike heartbeat which does), (2) `squad:copilot` label is gated on `🤖 Coding Agent` in `team.md` which was never added — label won't exist, workflow will 422, (3) Copilot instructions reference `.github/templates/ARTICLE_TEMPLATE.md` which describes `articles.md` line-item format, not `articles/{slug}.md` per-file format — contradicts the correct `articles/.template.md` reference on the same instruction block.
- **Lesson:** When a workflow depends on a label, that label must either be synced unconditionally or the dependency chain must be explicit. Don't gate infrastructure labels on optional roster markers.
- **Lesson:** Always verify that template references in generated instructions point to the right template for the right output format.
- **Revision owner:** Amy (Platform Engineer) — Bender is locked out as original author.

### Content Intake Review — Approved (2026-06-27)
- **Verdict:** Approved. Amy fixed all three blockers from the prior rejection.
- **Blocker 1 (token fallback):** `assign-copilot` job now uses `secrets.COPILOT_ASSIGN_TOKEN || secrets.GITHUB_TOKEN`. The `route-content` job detects presence/absence and posts honest messaging. Assignment step is gated behind a preflight check, so no crash when the secret is missing.
- **Blocker 2 (label availability):** `🤖 Coding Agent` marker now present in `.squad/team.md`. Detection logic uses `|| content.includes('@copilot')` as belt-and-suspenders. Workflow also defensively creates `squad:copilot` inline if missing — no dependency on sync timing.
- **Blocker 3 (template mismatch):** Workflow instructions now consistently reference `articles/.template.md` / `repos/.template.md`. No references to `.github/templates/ARTICLE_TEMPLATE.md` in the automated path. New `.github/templates/README.md` disambiguates the two template sets.
- **Soft findings (non-blocking):** `CONTENT_INTAKE_FIX_VALIDATION.md` in repo root is a review artifact, not project docs — should be removed before merge. `COPILOT_TOKEN` env var on assign-copilot step is set but unused (dead code). `CONTENT_SYSTEM_INDEX.md` in `.github/templates/` is stale from original Bender work and describes the old submission flow — track cleanup separately.
- **Lesson:** A revision cycle works. Clear blocker list → specific fix owner → re-review. Amy delivered a clean fix without scope creep.
