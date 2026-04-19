# Contributing to AI-DrivenDevEnv

Thank you for contributing to a documentation-first toolkit for agentic AI development. We welcome issues, documentation improvements, scripts, and integration patterns.

## Table of Contents

- [Issues](#issues)
- [Pull Requests](#pull-requests)
- [Documentation & Scripts](#documentation--scripts)
- [Squad Integration](#squad-integration)
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

### Squad Integration

If your contribution involves [Squad](https://github.com/bradygaster/squad) patterns (multi-agent workflows, `.squad/` templates, agent charters):

- Place Squad-related docs and templates in `.squad/templates/` or `.squad/agents/`
- Reference Squad patterns in setup guides where they add value
- **Do not overstate Squadron capabilities** — describe it as human-led AI agent orchestration, GitHub Copilot–based, and experimental/alpha

### Review Process

- Our team reviews PRs for alignment with the toolkit's goals
- We may request changes for clarity, testing, or consistency
- Once approved, your changes will be merged into `master`

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

By contributing, you agree your work is licensed under MIT.

---

**Questions?** Open an issue or reach out to the maintainer. Thanks for helping build better agentic AI dev environments!
