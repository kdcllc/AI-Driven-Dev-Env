# Article Entry Template

**Use this as the markdown template for new article entries.**

---

## Entry Structure

Each article entry in `articles.md` follows this format:

```markdown
- **[TITLE](URL)** – SHORT_SUMMARY | **Tags:** tag1, tag2
```

### Fields

| Field | Type | Max Length | Notes |
|-------|------|-----------|-------|
| **TITLE** | string | 60 chars | Display title; match source or simplify |
| **URL** | URI | – | Direct link; HTTPS preferred |
| **SHORT_SUMMARY** | string | 120 chars | One-line value prop; crisp, no flowery language |
| **Tags** | comma-list | – | 2–5 tags max; see Tag Registry below |

### Example

```markdown
- **[Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents)** – Anthropic's guide to designing agentic systems with LLMs; foundational reading. | **Tags:** agents, design, LLMs
```

---

## Category & Indexing Rules

### Categories (in `articles.md`)

Entries are grouped under these headers. **Maintain alphabetical order within each section** to reduce merge conflicts.

1. **Agent Frameworks & Design** – Architecture, design patterns, system thinking
2. **Multi-Agent Orchestration** – Team coordination, routing, state management
3. **Retrieval-Augmented Generation (RAG)** – Semantic search, chunking, vector DBs
4. **AI Models & Fine-Tuning** – Model selection, training, optimization
5. **LLM Optimization & Cost** – Inference speed, token reduction, caching
6. **Security & Compliance** – Auth, data privacy, governance
7. **Observability & Monitoring** – Logging, tracing, debugging
8. **Testing & Evaluation** – Benchmarking, validation, quality gates
9. **DevOps & Deployment** – CI/CD, infrastructure, cloud integration
10. **AI Blogs & Journals** – Newsletter-style, regular updates (lower priority for detailed indexing)

### Placement Rule

- **New articles:** Add to the **single most relevant category**
- **Broad topics:** Default to most popular category, note secondary fit in summary
- **Journals/blogs:** Use "AI Blogs & Journals" unless entry is specific to a topic

---

## Tag Registry

**Standard tags** (lowercase, no spaces):

- **Frameworks/Platforms:** anthropic, azure, openai, semantic-kernel, squad, langchain, haystack, llamaindex
- **Languages:** python, dotnet, csharp, javascript, typescript, java, golang
- **Patterns:** agents, rag, multiagent, fine-tuning, prompt-engineering, reasoning, streaming
- **Topics:** security, cost-optimization, observability, performance, testing

Use 2–5 tags per entry. Prefer framework/language over vague labels.

---

## Approval Checklist (for Squad Members Creating PR)

- [ ] URL is live and accessible (test with `curl -I`)
- [ ] Title matches source or is a sensible simplification (≤60 chars)
- [ ] Summary is crisp, no marketing speak (≤120 chars, ends with period)
- [ ] Category is singular and correct; placed alphabetically within section
- [ ] Tags are lowercase, from registry, 2–5 items
- [ ] Markdown formatting matches existing entries exactly
- [ ] No duplicate (check articles.md + code.md before adding)
- [ ] Commit message: `docs: add article "[Title]" to [Category]`

---

## Related

- **[code.md](../code.md)** – Repository entries (similar rules, table format)
- **[Submission Issue Template](../issue_templates/content-submission.yml)** – How users submit content
