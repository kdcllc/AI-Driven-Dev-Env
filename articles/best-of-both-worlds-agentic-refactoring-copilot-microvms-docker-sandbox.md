# Best of Both Worlds for Agentic Refactoring: GitHub Copilot + MicroVMs via Docker Sandbox

- **URL:** https://devblogs.microsoft.com/all-things-azure/best-of-both-worlds-for-agentic-refactoring-github-copilot-microvms-via-docker-sandbox/
- **Source:** devblogs.microsoft.com
- **Date Added:** 2026-04-19
- **Category:** Agent Frameworks & Design

## Summary

This article presents a solution for modernizing legacy codebases by combining GitHub Copilot's agentic refactoring capabilities with Docker Sandbox's MicroVM-based isolation. Docker Sandbox mirrors the host workspace with identical absolute paths inside a secure MicroVM, allowing Copilot to containerize and refactor legacy applications without exposing host-level Docker access. The result is a workflow where AI agents perform meaningful code modernization—building, testing, and validating changes—inside an isolated environment that syncs results back to the host seamlessly.

## Key Takeaways

- Docker Sandbox uses MicroVM isolation to give agents a private Docker daemon, removing the need for risky host Docker socket access during agentic workflows.
- Bidirectional workspace sync preserves absolute paths between host and sandbox, so refactored code and build outputs move back without breaking references.
- GitHub Copilot acts as the agentic driver, containerizing and modernizing legacy Java/.NET apps entirely within the sandboxed environment.

## Relevance to AI-Driven Development

This pattern directly addresses the security and isolation challenges of running AI coding agents on real codebases, making it essential reading for teams adopting agentic workflows with GitHub Copilot. It provides a practical blueprint for safely automating legacy modernization tasks that are otherwise too risky to hand off to an autonomous agent.
