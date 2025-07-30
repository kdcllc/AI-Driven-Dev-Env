# Copilot Instructions for AI-DrivenDevEnv

## Project Overview
- **Purpose:** Scripts and docs for automating dev environment setup, especially on Linux (Ubuntu). Focus on AI/LLM integration and toolchain bootstrapping.
- **Key Directories:**
  - `linux/` — OS-specific setup docs and scripts
  - `win/` — Windows-specific setup docs and scripts
  - `images/` — Project images
  - Root scripts (e.g., `run-aider.sh`) — Main entry points

## Architecture & Patterns
- **Script-Driven:** Most automation is via shell scripts in `linux/scripts/` and root.
- **Documentation-First:** Each tool/tech has a dedicated markdown doc in `linux/` or `win/`.
- **Model Integration:** Designed to work with local and remote LLMs (e.g., `qwen2.5-coder`, `llama3.1`, `gptme`).
- **No monolithic app code** — this repo is a toolkit, not a single application.

## Developer Workflows
- **Setup (Linux):**
  - Clone repo, then run `./run-aider.sh` (main entry point)
  - For Azure config: `./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>`
  - For ODBC: `sudo ./linux/scripts/install-odbc.sh`
- **Docs:**
  - See `linux/README.md` for Linux-specific tool usage
  - See `win/README.md` for Windows-specific notes
- **Model Usage:**
  - LLMs are referenced in docs/scripts, not managed by a central orchestrator
  - Example: `gptme -m azure/gpt-4o` or `OPENAI_BASE_URL=... gptme ...`

## Conventions & Patterns
- **Scripts are idempotent** where possible; safe to re-run
- **Docs and scripts are tightly coupled** — update both when changing workflows
- **No central config file** — settings are passed via env vars or script args
- **Linux is primary target**; Windows support is secondary

## Integration Points
- **External:** Azure, ODBC, LLMs (local/remote)
- **Internal:** Scripts call each other, but no deep code dependencies

## Examples
- To set up a dev environment:
  ```bash
  git clone https://github.com/kdcllc/AI-DrivenDevEnv.git
  cd AI-DrivenDevEnv
  ./run-aider.sh
  ```
- To configure Azure:
  ```bash
  ./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>
  ```

## Key Files
- `run-aider.sh` — Main entry point for environment setup
- `linux/scripts/` — All major automation scripts
- `linux/README.md` — Linux-specific toolchain notes
- `win/README.md` — Windows-specific toolchain notes

---
If any workflow or integration is unclear, check the relevant `README.md` or script in `linux/` or `win/`.
