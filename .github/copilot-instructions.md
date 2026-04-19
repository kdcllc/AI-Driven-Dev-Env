# Copilot Instructions for AI-DrivenDevEnv

> **Note:** This project uses [Squad](https://github.com/bradygaster/squad) for human-led agent coordination. Squad team members have access to `.squad/` for shared state, decisions, and role-specific charters. If you're part of the Squad, also read `.squad/team.md` and your agent charter at `.squad/agents/{your-name}/charter.md`.

## Project Overview

- **Purpose:** Documentation-first toolkit for agentic AI developer workflows, setup guides, and reusable Copilot/Squad patterns
- **Philosophy:** Context engineering over clever prompts. Explicit patterns, central docs, repeatable workflows.
- **Key Directories:**
  - `linux/` — OS-specific setup docs and scripts
  - `win/` — Windows-specific setup docs and scripts
  - `articles/` — Auto-generated article summaries (via issue intake)
  - `repos/` — Auto-generated repo summaries (via issue intake)
  - `images/` — Project images
  - `.squad/` — Persistent team state (Squad members only)
  - Root scripts (e.g., `run-aider.sh`) — Main entry points

## Architecture & Patterns

- **Script-Driven:** Most automation is via shell scripts in `linux/scripts/` and root
- **Documentation-First:** Each tool/tech has a dedicated markdown doc in `linux/` or `win/`
- **Model Integration:** Designed to work with local and remote LLMs (e.g., `qwen2.5-coder`, `llama3.1`, `gptme`)
- **No monolithic app code** — this repo is a toolkit, not a single application
- **Context as Code:** Custom instructions, prompt files, and `.squad/` state are the "interface" to this repo

## Developer Workflows

### For Individual Developers

- **Setup (Linux):**
  - Clone repo, then run `./run-aider.sh` (main entry point)
  - For Azure config: `./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>`
  - For ODBC: `sudo ./linux/scripts/install-odbc.sh`
- **Copilot Chat / Aider:**
  - Read `.github/copilot-instructions.md` (this file) for context
  - Reference `ai-coding.md` for guidance on context engineering and agent workflows
  - Use `.github/prompts/` for repeatable task definitions

### For Squad Team Members

- **Before starting:** Check `.squad/decisions.md` for active decisions
- **Your role:** Read `.squad/agents/{your-name}/charter.md` to understand your specialty
- **Handoffs:** Review `.squad/routing.md` to see when to pass work to another agent
- **State:** Use `.squad/log/` to track work; Scribe merges logs into history
- **Decisions:** Write to `.squad/decisions/inbox/` when others need to know about a decision

## Conventions & Patterns

- **Scripts are idempotent** where possible; safe to re-run
- **Docs and scripts are tightly coupled** — update both when changing workflows
- **No central config file** — settings are passed via env vars or script args
- **Linux is primary target**; Windows support is secondary
- **Context is everything** — When in doubt, add more docs, not fewer

### Content Intake Pattern

Articles and repos are added via GitHub issue templates (`content:article`, `content:repo`). The `content-intake.yml` workflow auto-routes these to Copilot, which:
1. Reads the URL from the issue
2. Creates a summary file using the template in `articles/.template.md` or `repos/.template.md`
3. Updates `articles/index.md` or `repos/index.md` with the new entry
4. Opens a PR for human review

Repository setup matters here: keep `@copilot` in `.squad/team.md`, sync labels so `squad:copilot` exists, and configure `COPILOT_ASSIGN_TOKEN` if you want GitHub Actions to assign the Copilot coding agent automatically. Without that secret, the workflow should leave clear manual next steps instead of pretending the repo is zero-config.

**Do NOT** modify `articles.md` or `code.md` from content intake — those are manually curated.

## Integration Points

- **External:** Azure, ODBC, LLMs (local/remote)
- **Internal:** Scripts call each other; Copilot/aider/Squad agents coordinate via this file, `.squad/`, and prompt files
- **Orchestration:** Squad uses GitHub Copilot agent mode to coordinate specialists

## When You Get Stuck

1. **Don't know how to do something?** → Check `ai-coding.md` for context engineering and agent guidance
2. **Not sure about project conventions?** → Look at existing scripts and docs; they are the source of truth
3. **Need to coordinate with team?** → Use `.squad/decisions.md` or write to `.squad/decisions/inbox/`
4. **Debugging a script or setup?** → Check `linux/README.md` or the specific doc for that tool (e.g., `linux/aider-chat.md`)

## Examples

### Set Up a Dev Environment (Individual)

```bash
git clone https://github.com/kdcllc/AI-DrivenDevEnv.git
cd AI-DrivenDevEnv
./run-aider.sh
```

### Configure Azure (Individual)

```bash
./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>
```

### Working with Squad

1. Check team decisions: `cat .squad/decisions.md`
2. Find your charter: `cat .squad/agents/farnsworth/charter.md` (or your role)
3. See routing logic: `cat .squad/routing.md`
4. Get started on a task in chat, let Copilot route to the right specialist

## Key Files & Directories

- **`.github/copilot-instructions.md`** — This file; AI instructions for the project
- **`ai-coding.md`** — Deep dive into context engineering, Copilot modes, Squad patterns
- **`run-aider.sh`** — Main entry point for environment setup
- **`linux/scripts/`** — All major automation scripts
- **`linux/README.md`** — Linux-specific toolchain notes
- **`win/README.md`** — Windows-specific toolchain notes
- **`.squad/`** — Persistent team state (Squad members)
  - `.squad/team.md` — Team roster and structure
  - `.squad/decisions.md` — Active decisions and governance
  - `.squad/agents/{name}/charter.md` — Individual agent responsibilities and patterns
  - `.squad/routing.md` — How work flows between agents
- **`articles/`** — Auto-generated article summaries
  - `articles/.template.md` — Template for new article entries
  - `articles/index.md` — Category-based article index
- **`repos/`** — Auto-generated repo summaries
  - `repos/.template.md` — Template for new repo entries
  - `repos/index.md` — Category-based repo index

## Responsible AI & Security

- **Review AI-generated code**: Always validate Copilot's suggestions for correctness, security, and compliance before using them in production
- **Never include secrets or credentials** in prompts, code, or `.squad/` state
- **Understand limitations:** Copilot, aider, and Squad are tools. Humans make final decisions.
- **Privacy:** Keep personal data and proprietary information out of AI-assisted workflows

---

**Need help?** Check the README files in `linux/` or `win/`, or read `ai-coding.md` for deeper context engineering guidance.
