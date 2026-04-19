# AI-Driven Development Environment

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/kdcllc/AI-DrivenDevEnv/master/LICENSE) [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

A **documentation-first toolkit** for setting up agentic AI development environments on Linux and Windows. Includes scripts, configuration guides, and integration patterns for AI-driven development workflows powered by GitHub Copilot and [Squad](https://github.com/bradygaster/squad) (human-led AI agent orchestration).

**Quick Start:**  
```bash
git clone https://github.com/kdcllc/AI-DrivenDevEnv.git
cd AI-DrivenDevEnv && chmod +x run-aider.sh && ./run-aider.sh
```

## What This Is

A curated collection of:
- **Setup scripts** for Linux (Ubuntu) and Windows dev tools
- **Configuration guides** for AI models (local and cloud)
- **Integration patterns** for Squad-based multi-agent workflows
- **Reusable documentation** to onboard new developers quickly

## Core Directories

- **`linux/`** – Linux setup guides and scripts (primary platform)
- **`win/`** – Windows setup notes and tools
- **`images/`** – Project diagrams and assets
- **Root scripts** – Entry points like `run-aider.sh`

## Getting Started

### Prerequisites

- **Linux:** Ubuntu 18.04, 20.04, 22.04, 23.04, or 24.04 (recommended)
- **Windows:** Windows 11 with WSL2 or native tooling (see `win/README.md`)
- Git, Python 3.x

### Quick Setup (Linux)

1. **Clone and enter the directory:**
   ```bash
   git clone https://github.com/kdcllc/AI-DrivenDevEnv.git
   cd AI-DrivenDevEnv
   ```

2. **Run the main setup script:**
   ```bash
   chmod +x run-aider.sh
   ./run-aider.sh
   ```

3. **(Optional) Configure Azure:**
   ```bash
   chmod +x linux/scripts/aider-az-setup.sh
   ./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>
   ```

4. **(Optional) Install ODBC for SQL Server:**
   ```bash
   sudo chmod +x linux/scripts/install-odbc.sh
   sudo ./linux/scripts/install-odbc.sh
   ```

### Using Squad for Multi-Agent Workflows

For teams building agentic AI systems, integrate [Squad](https://github.com/bradygaster/squad) alongside this toolkit:

- Squad stores persistent multi-agent state in `.squad/` (repo-resident)
- Pair Squad with `run-aider.sh` to bootstrap agent teams in your project
- See [CONTRIBUTING.md](CONTRIBUTING.md) for Squad integration patterns

## Documentation

- **[linux/README.md](linux/README.md)** – Tool reference for Linux setup
- **[win/README.md](win/README.md)** – Windows-specific notes and Python setup
- **[articles.md](articles.md)** – Curated links on AI agents, RAG, and frameworks
- **[articles/index.md](articles/index.md)** – Auto-generated article summaries (by category)
- **[code.md](code.md)** – Related repositories and projects
- **[repos/index.md](repos/index.md)** – Auto-generated repo summaries (by category)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** – Contribution guidelines and patterns

### Adding Articles & Repos

Found a useful article or GitHub repo? Add it in seconds:

1. **Article:** Open a [📰 Add Article](https://github.com/kdcllc/AI-DrivenDevEnv/issues/new?template=content-article.yml) issue — paste the URL and pick a category
2. **Repo:** Open a [📦 Add Repository](https://github.com/kdcllc/AI-DrivenDevEnv/issues/new?template=content-repo.yml) issue — paste the URL and pick a category

A Copilot agent automatically summarizes the content and opens a PR. You just review and merge.

### Key Setup Guides

See `linux/` for detailed docs on:
- [open-webui.md](linux/open-webui.md) – Local LLM UI
- [dotnetcore.md](linux/dotnetcore.md) – .NET toolchain
- [pipx.md](linux/pipx.md) – Isolated Python tool management
- [poetry.md](linux/poetry.md) – Python project dependencies
- [pyenv.md](linux/pyenv.md) – Multiple Python versions

## About This Project

Maintained by [kdcllc](mailto:kingdavidconsulting@gmail.com).  
If this toolkit helped you, consider [buying me a coffee](https://www.buymeacoffee.com/vyve0og) or giving it a star ⭐.

![I stand with Israel](./images/IStandWithIsrael.png)

