# Hermes — History

## Latest Session: 2026-04-19 Doc Refresh

Reframed core documentation (README.md, CONTRIBUTING.md, articles.md, code.md, win/README.md) as documentation-first toolkit for agentic AI development. Integrated Squad positioning naturally. Reduced personal branding clutter while maintaining docstring-first culture.

**Status:** Implementation complete, decisions merged.

---

[Previous work retained for continuity]

## Latest Session: 2026-06-27 Content Submission System Design

Designed a scalable content output system for automated article/repo ingestion triggered by GitHub issues.

**Deliverables:**
1. Issue template (`.github/issue_templates/content-submission.yml`) — user-facing form for article/repo submissions
2. Article template (`.github/templates/ARTICLE_TEMPLATE.md`) — markdown format, field specs, approval checklist
3. Repository template (`.github/templates/REPOSITORY_TEMPLATE.md`) — table format, categorization rules, decision tree
4. System index (`.github/templates/CONTENT_SYSTEM_INDEX.md`) — flow, file structure, update rules, preventing common issues

**Key Decisions:**
- Alphabetical ordering within categories to minimize merge conflicts
- 2–5 tags from fixed registry; no tag sprawl
- Summary max 120 chars; crisp, no marketing language
- Squad member adds value (not just copy-paste)
- Scalable for 100+ entries using frontmatter or standalone generator later

**Patterns Established:**
- Submission → Triage → PR with proper placement → Merge
- Clear Squad member approval checklist
- Categories are gated (no ad-hoc additions)

**File Paths:**
- `.github/issue_templates/content-submission.yml`
- `.github/templates/ARTICLE_TEMPLATE.md`
- `.github/templates/REPOSITORY_TEMPLATE.md`
- `.github/templates/CONTENT_SYSTEM_INDEX.md`
