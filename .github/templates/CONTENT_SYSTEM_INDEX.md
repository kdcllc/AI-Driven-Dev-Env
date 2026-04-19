# Content Submission & Index System

**System design & index update rules for automated article / repository ingestion.**

---

## Overview

This toolkit curates articles and repositories via **team-driven submissions**. Users discover useful content and file an issue; a Squad member creates a PR with a properly formatted entry, category placement, and index updates.

**Goal:** Scale cleanly to 100+ entries without broken links, outdated categories, or merge conflicts.

---

## Submission Flow

### 1. User Discovers Content
- Finds article on [devblogs.microsoft.com](https://devblogs.microsoft.com/), GitHub, or elsewhere
- Wants to add it to this toolkit

### 2. User Files Issue
- Opens `.github/issue_templates/content-submission.yml`
- Fills in:
  - Content type (Article or Repository)
  - URL (required)
  - Title
  - Category / Use Case
  - Optional: Summary, Tags, Context
- Submits with label `content`

### 3. Squad Member Triages & Creates PR
- Reviews issue for completeness and relevance
- Extracts/refines summary if not provided (Squad member adds value, not just copy-paste)
- Verifies URL is live and no duplicate exists
- Creates PR with:
  - Entry added to `articles.md` or `code.md`
  - Proper category and alphabetical placement
  - Tags applied (from Tag Registry)
  - Index entry in `index.md` (if using categorized index; see below)
  - Clean commit message
- Assigns to content review

### 4. Merge & Indexing
- Entry is live in `articles.md` or `code.md`
- Index updated if using categorized approach (optional; see Indexing Strategy)

---

## File Structure

```
AI-DrivenDevEnv/
├── articles.md                 # Article entries (links + summaries)
├── code.md                     # Repository entries (table format)
├── index.md                    # (Optional) Categorical index for discoverability
├── .github/
│   ├── issue_templates/
│   │   └── content-submission.yml  # User-facing submission form
│   └── templates/
│       ├── ARTICLE_TEMPLATE.md     # Guidelines & approval checklist
│       ├── REPOSITORY_TEMPLATE.md  # Guidelines & approval checklist
│       └── CONTENT_SYSTEM_INDEX.md # This file
```

---

## articles.md Structure

### Format

**Section Header** (Category)
```markdown
- **[Title](URL)** – Summary | **Tags:** tag1, tag2
```

### Alphabetical Ordering Rule

Within each category section, entries are sorted **A–Z by title** (first letter after any article like "A" or "The").

**Why?** Reduces merge conflicts and makes scanning predictable.

**Example ordering:**
```markdown
## Agent Frameworks & Design
- **[A framework for agents](URL)** – ...
- **[Building Effective Agents](URL)** – ...
- **[The Multi-Agent Landscape](URL)** – ...
```

### Current Categories (in order of appearance)

1. Agent Frameworks & Design
2. Multi-Agent Orchestration
3. Retrieval-Augmented Generation (RAG)
4. AI Models & Fine-Tuning
5. LLM Optimization & Cost
6. Security & Compliance
7. Observability & Monitoring
8. Testing & Evaluation
9. DevOps & Deployment
10. AI Blogs & Journals

**Do not rename, reorder, or add categories** without team consensus (use `.squad/decisions/inbox/` to propose).

---

## code.md Structure

### Format

**Section Header** (Category)
```markdown
| [Repository Name](URL) | Summary | Key Focus |
|---|---|---|
| [Name](URL) | Description | tech stacks, patterns |
```

### Alphabetical Ordering Rule

Within each section, sort by repository name **A–Z** (ignore "The", "A").

**Why?** Same as articles.md — predictable, reduces conflicts.

### Current Sections (in order)

1. Core to This Toolkit
2. Agent Frameworks & Orchestration
3. Python Agent & RAG Stacks
4. Dotnet / C# Stacks
5. Specialty (E-commerce, Workshops, Research)
6. Related Tooling

**Do not rename, reorder, or add sections** without team consensus.

---

## Indexing Strategy (Optional)

### Approach 1: Single-File Index (Simple)
**Recommended for ≤50 entries.**

Create `index.md` that mirrors categories but adds metadata:

```markdown
# Content Index

## Agent Frameworks & Design
- [Building Effective Agents](link) – Anthropic guide
  - Tags: agents, design, foundational
  - Type: Article
  - Format: Guide
```

**Pros:** Simple, one file, no sync overhead
**Cons:** Manual updates, doesn't scale past ~50 entries

### Approach 2: Embedded Frontmatter (Scalable)
**Recommended for ≥50 entries or if automation is added later.**

Add YAML frontmatter to `articles.md` and `code.md`:

```markdown
---
index_version: 1
categories:
  - Agent Frameworks & Design
  - Multi-Agent Orchestration
tags_registry:
  - anthropic
  - azure
  - agents
last_updated: 2026-06-27
---

# AI-Related Learning Resources
...
```

**Pros:** Machine-readable, supports CLI tooling, auto-indexing possible
**Cons:** Slightly more overhead, requires parsing logic if building search/filter UIs

### Approach 3: Standalone Index Generator (Future)
**For when entries exceed 100 or search features are needed.**

Build a simple script (Python/Node) that:
1. Parses `articles.md` and `code.md` (markdown or frontmatter)
2. Generates `index.md` with search-friendly metadata (JSON/YAML)
3. Runs on PR or scheduled sync

**This keeps the main files clean and enables powerful discovery later.**

---

## Update Rules

### Adding a New Entry

1. **Verify:**
   - URL is live (curl or browser test)
   - No duplicate in articles.md or code.md
   - Title ≤60 chars (for articles) or matches repo name (for repos)
   - Summary ≤120 chars (clear, no marketing speak)
   - Category is valid and singular

2. **Placement:**
   - Identify correct category (use decision tree in `REPOSITORY_TEMPLATE.md` for repos)
   - Find alphabetical position within section
   - Insert entry in correct row/line

3. **Tags:**
   - Use 2–5 tags from Tag Registry (see templates)
   - Lowercase, comma-separated
   - No spaces in tag names

4. **Commit:**
   - Message: `docs: add [article|repository] "[Title]" to [Category]`
   - Include Co-authored-by trailer if from Squad

### Updating an Existing Entry

**Never delete without consensus.** Instead:

- **Broken link?** Mark `(⚠️ Link may be outdated)` in summary, note in PR description
- **Better summary?** Update summary only; keep URL and category
- **Wrong category?** Move to correct section; note in commit message why
- **Duplicate?** Close as duplicate in issue; do not add

### Removing an Entry

**Reasons to remove:**
- Repository is archived or deleted (3 months no activity)
- Content is genuinely obsolete (e.g., deprecated framework)
- Spam or off-topic

**Process:**
- File an issue with reason
- Squad consensus required (use `.squad/decisions/inbox/` if needed)
- Commit message: `docs: remove [entry] — [reason]`

---

## Preventing Common Issues

| Issue | Root Cause | Prevention |
|-------|-----------|-----------|
| Alphabetical chaos | No clear rule | Enforce A–Z by title within section; review PRs for order |
| Duplicate entries | Not checking both files | Submission form asks for dedup check; Squad double-checks |
| Broken links | Dead or moved URLs | Squad tests URL with curl or browser before merge |
| Category creep | New categories added ad-hoc | Gate category changes via team decisions |
| Tags sprawl | No registry | Use predefined Tag Registry; reject non-standard tags in review |
| Long summaries | No character limit | Submission form and templates enforce 120 char max |
| Merge conflicts | Manual editing at same spot | Alphabetical ordering minimizes overlap |

---

## Squad Member Checklist

When reviewing a content submission issue and creating a PR:

- [ ] URL is live and accessible
- [ ] No duplicate in articles.md or code.md
- [ ] Title / summary match source (simplified if needed)
- [ ] Category is valid and only one selected
- [ ] Alphabetical placement within category is correct
- [ ] Tags are from Tag Registry and 2–5 items
- [ ] Markdown formatting matches existing entries exactly
- [ ] Commit message is clean: `docs: add [article|repo] "[Title]"`
- [ ] Co-authored-by trailer included: `Co-authored-by: Copilot <...>`

---

## Related

- **[ARTICLE_TEMPLATE.md](../templates/ARTICLE_TEMPLATE.md)** – Article format & approval rules
- **[REPOSITORY_TEMPLATE.md](../templates/REPOSITORY_TEMPLATE.md)** – Repository format & approval rules
- **[Issue Template: content-submission.yml](../issue_templates/content-submission.yml)** – User submission form
- **[articles.md](../../articles.md)** – Live article entries
- **[code.md](../../code.md)** – Live repository entries
