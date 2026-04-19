# Content Submission & Curation Workflow

Welcome to the **AI-DrivenDevEnv Content System**. This toolkit curates articles and repositories via team-driven submissions.

---

## Quick Start (for Users)

### Found an article or repo you want to share?

1. **Go to Issues** → **New Issue**
2. **Choose:** "📚 Add Article or Repository"
3. **Fill out the form:**
   - Content type (Article or Repository)
   - URL
   - Title
   - Category
   - (Optional) Summary, tags, context
4. **Submit** with label `content`

A Squad team member will create a PR with a properly formatted entry.

---

## For Squad Members (Creating PRs)

### Submission Review & PR Creation

1. **Receive triage label** `content` on an issue
2. **Verify:**
   - URL is live and accessible (use `curl -I https://...` to test)
   - No duplicate in `articles.md` or `code.md`
   - Title & summary are provided or extracts are clear
   - Category is from the approved list (see templates)

3. **Create PR:**
   - **For articles:** Add entry to `articles.md` using format in [ARTICLE_TEMPLATE.md](.github/templates/ARTICLE_TEMPLATE.md)
   - **For repositories:** Add entry to `code.md` using format in [REPOSITORY_TEMPLATE.md](.github/templates/REPOSITORY_TEMPLATE.md)
   - **Placement:** Alphabetical order within category (reduces merge conflicts)
   - **Tags:** Use 2–5 from Tag Registry (see templates)
   - **Commit message:** `docs: add [article|repository] "[Title]" to [Category]`
   - Include trailer: `Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>`

4. **Use the approval checklist** from your template (ARTICLE or REPOSITORY)

---

## Documentation & Guidelines

### User-Facing
- **[Issue Template](issue_templates/content-submission.yml)** – How users submit

### Squad-Facing
- **[ARTICLE_TEMPLATE.md](templates/ARTICLE_TEMPLATE.md)** – Article format, fields, approval checklist
- **[REPOSITORY_TEMPLATE.md](templates/REPOSITORY_TEMPLATE.md)** – Repository format, decision tree, approval checklist
- **[CONTENT_SYSTEM_INDEX.md](templates/CONTENT_SYSTEM_INDEX.md)** – System design, flow, rules, and preventing issues

### Content Files
- **[articles.md](../articles.md)** – Live article entries
- **[code.md](../code.md)** – Live repository entries

---

## Categories & Rules

### Articles (articles.md)

Fixed categories (alphabetical placement within each):
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

### Repositories (code.md)

Fixed sections (alphabetical placement within each):
1. Core to This Toolkit
2. Agent Frameworks & Orchestration
3. Python Agent & RAG Stacks
4. Dotnet / C# Stacks
5. Specialty (E-commerce, Workshops, Research)
6. Related Tooling

Use the **decision tree** in [REPOSITORY_TEMPLATE.md](templates/REPOSITORY_TEMPLATE.md) to determine placement.

---

## Tag Registry

**Standard tags** (use 2–5 per entry, lowercase):
- **Frameworks:** anthropic, azure, openai, semantic-kernel, squad, langchain, haystack, llamaindex
- **Languages:** python, dotnet, csharp, javascript, typescript, java, golang
- **Patterns:** agents, rag, multiagent, fine-tuning, prompt-engineering, reasoning
- **Topics:** security, cost-optimization, observability, performance, testing

---

## Common Issues & Prevention

| Issue | Solution |
|-------|----------|
| Merge conflicts (alphabetical chaos) | Enforce A–Z ordering; review PR diffs before merge |
| Duplicates | Submission form + Squad double-check (verify both files) |
| Broken links | Squad tests URL before merge |
| Category creep | Gate new categories via `.squad/decisions/` consensus |
| Tag sprawl | Use Tag Registry only; reject non-standard tags in review |
| Long summaries | Enforce 120 char max in submission & templates |

---

## Scaling (Future)

**Currently:** Alphabetical ordering in markdown files  
**At 50+ entries:** Consider adding YAML frontmatter for machine-readability  
**At 100+ entries:** Build standalone index generator to enable search/filter UIs  

See [CONTENT_SYSTEM_INDEX.md](templates/CONTENT_SYSTEM_INDEX.md) for full scalability roadmap.

---

## Questions?

- **How do I submit?** See [Issue Template](issue_templates/content-submission.yml)
- **How do I create a PR?** See your role's template: [ARTICLE_TEMPLATE.md](templates/ARTICLE_TEMPLATE.md) or [REPOSITORY_TEMPLATE.md](templates/REPOSITORY_TEMPLATE.md)
- **What categories exist?** See this file or the target `articles.md` / `code.md`
- **Why alphabetical?** Reduces merge conflicts and makes scanning predictable
- **Can I add a new category?** No—gate changes via `.squad/decisions/` for team consensus

