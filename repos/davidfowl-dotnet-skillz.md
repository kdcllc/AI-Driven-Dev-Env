# dotnet-skillz

- **URL:** https://github.com/davidfowl/dotnet-skillz
- **Owner:** davidfowl
- **Language:** Markdown / Shell
- **Stars:** ~50
- **Date Added:** 2026-04-20
- **Category:** Developer Tooling

## Summary

dotnet-skillz is a collection of lightweight skill prompts for .NET CLI tools, designed to teach coding agents (such as GitHub Copilot and Claude Code) how to use those tools effectively. The current flagship skill, `ilspy-decompile`, enables agents to understand .NET implementation details by decompiling assemblies with ILSpy (`ilspycmd`). Skills are token-efficient markdown files that encode best practices and purpose-built command sequences without bloating LLM context.

## Key Features

- `ilspy-decompile` skill — guides coding agents to decompile .NET assemblies and explore implementation details using `dnx ilspycmd`
- Token-efficient skill format compatible with GitHub Copilot CLI (`/plugin marketplace add`) and Claude Code
- Skills-less fallback: agents can be pointed directly at a tool's `--help` output without installing any skill files
- Extensible design — new skills are added by creating a folder under `skills/<skill-name>/` with a `SKILL.md` file

## Relevance to AI-Driven Development

Agentic coding workflows often need to reason about compiled .NET libraries where source is unavailable; dotnet-skillz provides ready-made skill prompts that let agents decompile and inspect assemblies without manual tool discovery. It aligns directly with the skill-based agent tooling pattern used throughout this toolkit.
