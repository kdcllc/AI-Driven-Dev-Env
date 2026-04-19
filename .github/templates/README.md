# Template Directory

This directory contains **formatting guidelines** for manually curated content in the root-level files:

- **`ARTICLE_TEMPLATE.md`** — Format specs for entries in `articles.md` (the manually curated article list)
- **`REPOSITORY_TEMPLATE.md`** — Format specs for entries in `code.md` (the manually curated repository table)

## ⚠️ NOT FOR CONTENT INTAKE AUTOMATION

**These templates are NOT used by the content intake workflow.**

The automated content intake system (triggered by `content:article` or `content:repo` labels) uses different templates:

- **`/articles/.template.md`** — For individual article summaries added to `/articles/`
- **`/repos/.template.md`** — For individual repository summaries added to `/repos/`

## When to Use Each Template

| Use Case | Template Location | Target File |
|----------|------------------|-------------|
| Manually adding an entry to the curated article list | `.github/templates/ARTICLE_TEMPLATE.md` | `articles.md` |
| Manually adding an entry to the curated repository table | `.github/templates/REPOSITORY_TEMPLATE.md` | `code.md` |
| Automated article intake via issue | `articles/.template.md` | `articles/{slug}.md` |
| Automated repository intake via issue | `repos/.template.md` | `repos/{slug}.md` |

## Related

- **[Content Intake Workflow](../workflows/content-intake.yml)** — Automated summarization
- **[Content Issue Templates](../ISSUE_TEMPLATE/)** — How users submit content
