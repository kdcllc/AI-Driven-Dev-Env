# Contributing to AI-DrivenDevEnv

Thank you for contributing to a documentation-first toolkit for agentic AI development. We welcome issues, documentation improvements, scripts, and integration patterns.

## Table of Contents

- [Issues](#issues)
- [Pull Requests](#pull-requests)
- [Documentation & Scripts](#documentation--scripts)
- [Agent Orchestration](#agent-orchestration)
- [Code of Conduct](#code-of-conduct)
- [License](#license)

## Issues

Found a bug or have a feature request?

1. **Check existing issues** at [Issues](https://github.com/kdcllc/AI-DrivenDevEnv/issues) to avoid duplicates.
2. **Create a new issue** with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs. actual behavior
   - Environment (Ubuntu version, Python version, tools involved)
   - Error messages or logs (if applicable)

## Pull Requests

We welcome PRs for bug fixes, new setup guides, scripts, and documentation.

### Before You Start

- Fork the repository
- Create a branch from `master`: `git checkout -b feature/your-feature-name`
- Keep changes focused and atomic

### Submission Checklist

1. **Documentation & scripts stay in sync:** If you modify a tool's setup script in `linux/scripts/`, update the corresponding doc in `linux/` as well.
2. **Test your scripts** on at least one target environment (e.g., Ubuntu 22.04 or 24.04).
3. **Update relevant READMEs** if you're adding new tooling or patterns.
4. **Commit with clear messages:** Use present tense, e.g., "Add ODBC setup script for SQL Server."
5. **Push to your fork and create a PR** against `master`.

### Agent Orchestration

This repo uses [agent-kit](https://github.com/kdcllc/skills/tree/master/skills/agent-kit) for multi-agent work. If your contribution touches the orchestration setup:

- **Do not hand-edit kit-emitted files** (listed in `orchestration-kit.manifest.json`) — change the answers and re-emit with `bash .agents/skills/agent-kit/bin/emit.sh --upgrade`
- Record durable decisions as memory records (`_kit/memory.sh`), not ad-hoc notes
- Describe agent output as AI-assisted; humans review and merge

### Review Process

- Our team reviews PRs for alignment with the toolkit's goals
- We may request changes for clarity, testing, or consistency
- Once approved, your changes will be merged into `master`

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

By contributing, you agree your work is licensed under MIT.

---

**Questions?** Open an issue or reach out to the maintainer. Thanks for helping build better agentic AI dev environments!
