# Repository Entry Template

**Use this as the template for new repository entries in `code.md`.**

---

## Entry Structure

Each repository entry in `code.md` appears as a table row:

```markdown
| [Repository Name](https://github.com/...) | Short summary of what it does | Key focus areas |
```

### Fields

| Field | Type | Max Length | Notes |
|-------|------|-----------|-------|
| **Repository Name** | link | 40 chars | Use `[name](url)` markdown; match GitHub repo name |
| **URL** | URI | – | Full GitHub (or source) URL; HTTPS required |
| **Summary** | string | 120 chars | What does it do? Value for this toolkit? |
| **Key Focus** | comma-list | 80 chars | 1–3 tech stacks or primary patterns |

### Example

```markdown
| [agent-kit](https://github.com/kdcllc/skills/tree/master/skills/agent-kit) | Orchestrator/worker/evaluator multi-agent system for Claude Code, Cursor, Copilot, and Codex | Multi-agent orchestration, evaluator gates, `_memory/` project memory |
```

---

## Categorization Rules

### Sections (in `code.md`)

Group repositories under these headers; keep entries alphabetical **within each section** by repo name:

1. **Core to This Toolkit** – agent-kit, samples, reference implementations
2. **Agent Frameworks & Orchestration** – LangChain, semantic-kernel, etc.
3. **Python Agent & RAG Stacks** – FastAPI, Langchain, Haystack, etc.
4. **Dotnet / C# Stacks** – Semantic Kernel, MS AI extensions, etc.
5. **Specialty (E-commerce, Workshops, Research)** – Domain-specific demos
6. **Related Tooling** – Search, NLP, DevOps, deployment

### Placement Decision Tree

```
Is it directly used by this toolkit (agent-kit, samples)?
  YES → Core to This Toolkit
  NO  → Is it a multi-language framework or multi-agent pattern?
          YES → Agent Frameworks & Orchestration
          NO  → Is it Python-focused (FastAPI, Langchain, Haystack)?
                  YES → Python Agent & RAG Stacks
                  NO  → Is it .NET / C#?
                          YES → Dotnet / C# Stacks
                          NO  → Is it a domain demo (e-commerce, workshop)?
                                  YES → Specialty
                                  NO  → Related Tooling
```

---

## Approval Checklist (for Maintainers and Agents Creating PR)

- [ ] Repository is public and active (checked GitHub last commit ≤ 6 months ago)
- [ ] Name matches GitHub repo exactly; no extra branding
- [ ] URL points to GitHub or primary source; HTTPS only
- [ ] Summary is crisp, shows value for this toolkit (≤120 chars)
- [ ] Key Focus lists 1–3 primary tech stacks or patterns (not marketing fluff)
- [ ] Alphabetically positioned within its section
- [ ] No duplicate (check existing code.md before adding)
- [ ] Table formatting matches existing entries exactly (pipe alignment, spacing)
- [ ] Commit message: `docs: add repository "[Name]" to code.md`

---

## Tag/Focus Examples

**Common tech stacks:**
- Python, FastAPI, LangChain, Haystack, PostgreSQL
- .NET, C#, Azure Cognitive Services
- TypeScript, Node.js, React
- Kubernetes, Docker, Terraform, Bicep

**Common patterns:**
- Multi-agent orchestration
- RAG, vector search
- Fine-tuning, prompt engineering
- Semantic analysis, knowledge graphs
- E-commerce, e-learning, healthcare

---

## Related

- **[articles.md](../../articles.md)** – Article entries (similar rules, markdown list format)
- **[Article Submission Form](../ISSUE_TEMPLATE/content-article.yml)** and **[Repository Submission Form](../ISSUE_TEMPLATE/content-repo.yml)** – How users submit content
