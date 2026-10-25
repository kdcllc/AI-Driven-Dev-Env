# AI-Assisted Coding & Agentic Workflows

## Context Engineering: The Foundation

[Context Engineering](https://github.com/coleam00/context-engineering-intro) represents a paradigm shift from traditional prompt engineering. It's the discipline of structuring information so AI agents can reliably reason and act within your project.

### Prompt Engineering vs Context Engineering

| Aspect | Prompt Engineering | Context Engineering |
|--------|-------------------|---------------------|
| **Approach** | Clever wording and phrasing | Complete information architecture |
| **Scope** | How you ask the question | What the AI needs to know before answering |
| **Analogy** | Sticky note | Full screenplay with all details, cast, constraints |
| **Failure Mode** | Poor phrasing → wrong answer | Missing context → unpredictable behavior |

### Why Context Engineering Matters for Agentic AI

1. **Reduces Agent Failures**: Most agentic failures aren't model failures—they're **context failures**. Agents lack the project knowledge to make good decisions.
2. **Ensures Consistency**: Explicit patterns, conventions, and rules let AI follow your project's style and architecture.
3. **Enables Complex Workflows**: Multi-step implementations, tool use, and error recovery all depend on rich context.
4. **Self-Correcting Loops**: With proper context about validation and expectations, agents can detect and fix their own mistakes.
5. **Scales Across Teams**: When context is explicit, any agent (Copilot, Claude Code, aider, or an agent-kit subagent) can pick up where another left off.

### The Three Layers of Context Engineering

1. **Explicit Rules** — What the AI must/must not do (constraints, security, style)
2. **Project Knowledge** — Documentation, architecture, patterns, examples, error messages
3. **Validation & Feedback** — How to measure success, what to do if things break

This repo implements all three: custom instructions, markdown docs, runnable scripts, and agent-kit roles.


## GitHub Copilot: The Foundation

[Awesome Copilot templates](https://github.com/github/awesome-copilot)

### Custom Instructions

Define common guidelines for tasks like code generation, reviews, and commit messages. Custom instructions describe **how** tasks should be performed in your repo.

**Key Point**: Custom instructions only affect Copilot Chat (not inline code completions). Store them in `.github/copilot-instructions.md` at the repo root.

- Specify project patterns and conventions
- Define error handling, security, and testing expectations
- Reference key files and documentation
- Set tone and style for generated code

### Prompt Files

Prompt files are reusable Markdown (`.prompt.md` extension) that encode repeatable tasks: code generation, review, automation, etc. They can include:
- Metadata (mode, model, tools)
- References to custom instructions
- Task-specific constraints and examples
- Links to supporting docs

**Use prompt files to:**
- Standardize how tasks are described to Copilot
- Encapsulate multi-step workflows (test → lint → commit)
- Make automation repeatable across team members
- Store in `.github/prompts/` (workspace-level) or user profile

See: [Prompt files (experimental)](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-files-experimental)

### Agent Mode & Orchestration

**Modes** define how Copilot Chat operates:

- **ask**: Standard Q&A or code generation
- **edit**: Edit code based on instructions (refactor, fix, validate)
- **agent**: Enables tool use, workspace access, and multi-step automation

Agent mode is the foundation for complex workflows. It allows Copilot to:
- Use external tools (linters, test runners, Git, etc.)
- Access workspace context and files
- Reason over multiple steps and recover from errors

**This is where agent-kit enters the picture.**

### agent-kit: Orchestrator, Workers, Evaluators

[agent-kit](https://github.com/kdcllc/skills/tree/master/skills/agent-kit) is a multi-agent orchestration system compiled from one template source for Claude Code, Cursor, GitHub Copilot, and Codex. The main session acts as the **orchestrator**; it plans and delegates, but does not do the work itself.

**What agent-kit Provides:**

- **Worker subagents with fresh context** — `implementer`, `test-writer`, `evidence-collector`, `terminal`
- **Skeptical evaluators** — `evaluator` and `qa-evaluator` gate every change; `diagnostician` handles repeated failures
- **Tiered model pins** — frontier models decide and verify, light models execute, a fast model runs commands
- **Workflows as skills** — `/feature` (plan → implement → verify → ship PR) and `/research` (briefs under `_memory/research/`)
- **Project memory** — durable records in `_memory/`, searchable with `_kit/memory.sh`
- **Optional autonomous loop** — `_loop/loop.sh` works a backlog unattended; commits stay local

**How agent-kit Fits Into This Repo:**

1. **Roles are explicit** — each subagent has one job and a fixed tool allowlist
2. **Context is centralized** — `ORCHESTRATION.md`, custom instructions, skills, and memory live in the repo
3. **Verification is separate from execution** — the agent that wrote a change never grades it
4. **Handoffs are clear** — context packages are complete on first send, so subagents need no shared state

**Using agent-kit in AI-DrivenDevEnv:**

Start with `/feature <what you want>` in Claude Code or Copilot chat. Read `ORCHESTRATION.md` for phases and gates, and search past decisions with `_kit/memory.sh search <topic>`.

See: [agent-kit guide](https://github.com/kdcllc/skills/tree/master/docs/agent-kit/guide)

### MCP Servers

MCP (Model Context Protocol) servers extend Copilot's capabilities by providing access to external tools, APIs, or data sources. In agent mode, Copilot can connect to MCP servers to:

- Retrieve business data, documentation, or code context
- Perform actions via APIs or custom tools
- Integrate with enterprise systems

To use MCP servers:
1. Configure them in `.mcp/config.json` or VS Code settings
2. Reference them in prompt files or chat sessions
3. Let agent mode automatically invoke them

See: [MCP Servers for agent mode](https://code.visualstudio.com/insider/mcp)

### Tool Sets

Tool sets are collections of tools (linters, test runners, custom scripts) that Copilot can use in agent mode. Configure which tool sets are available in your workspace and reference them in prompt files.

Tool sets enable Copilot to:
- Run code analysis or tests
- Automate repetitive tasks
- Interact with your project's build or deployment pipeline
- Provide validation and feedback to the agent

In this repo, tool sets include shell scripts in `linux/scripts/` and test runners that Copilot can invoke.



---

## Microsoft-Specific Guidance for AI-Assisted Coding

### GitHub Copilot and Copilot for Azure

- **Review AI-generated code**: Always validate Copilot’s suggestions for correctness, security, and compliance before using them in production. Never include secrets or credentials in prompts or code.
- **Effective Prompt Engineering**: For best results, be clear and specific, set expectations, add scenario context, break down requests, and use Azure terminology. See [Write effective prompts for Microsoft Copilot in Azure](https://learn.microsoft.com/en-us/azure/copilot/write-effective-prompts).
- **Responsible AI**: Microsoft is committed to responsible AI principles—fairness, reliability, safety, privacy, inclusiveness, transparency, and accountability. Review outputs and understand limitations. See [Responsible AI FAQ for Microsoft Copilot in Azure](https://learn.microsoft.com/en-us/azure/copilot/responsible-ai-faq).

### Model Context Protocol (MCP)

- **Standardized Integrations**: MCP enables AI apps to connect to external tools and data sources for richer, context-aware responses. Supported in Copilot Studio, VS Code Copilot agent mode, and Semantic Kernel. See [Get started with .NET AI and the Model Context Protocol](https://learn.microsoft.com/en-us/dotnet/ai/get-started-mcp).
- **Architecture**: MCP uses a client-server model, allowing hosts (like VS Code) to connect to multiple MCP servers for contextual data.

### Microsoft 365 Copilot

- **Deployment and Adoption**: Use the [Copilot Success Kit](https://go.microsoft.com/fwlink/?linkid=2282402) and FastTrack for best practices on readiness, adoption, and analytics.
- **Security and Compliance**: Microsoft 365 Copilot follows strict privacy, security, and compliance standards, including GDPR and EU Data Boundary. See [Microsoft 365 Copilot Privacy](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-privacy).
- **Responsible AI and Security**: Microsoft applies responsible AI principles and a security development lifecycle to all Copilot products. See [AI security for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-ai-security).

### Additional Resources

- [What is GitHub Copilot for Azure?](https://learn.microsoft.com/en-us/azure/developer/github-copilot-azure/introduction#how-it-works)
- [Adopt, extend and build Copilot experiences across the Microsoft Cloud](https://learn.microsoft.com/en-us/microsoft-cloud/dev/copilot/overview#adopt-copilot)
