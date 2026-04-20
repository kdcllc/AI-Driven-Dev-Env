# AgentFrameworkToolkit

- **URL:** https://github.com/rwjdk/AgentFrameworkToolkit
- **Owner:** rwjdk
- **Language:** C#
- **Stars:** —
- **Date Added:** 2026-04-20
- **Category:** Agent Frameworks & Design

## Summary

AgentFrameworkToolkit is an opinionated C# wrapper around the Microsoft Agent Framework (MAF) that reduces boilerplate and surfaces provider-specific options in a discoverable way. It adds provider-tailored factories (`AgentFactory`, `AIToolsFactory`, `EmbeddingFactory`, `BatchRunner`) for providers including OpenAI, Azure OpenAI, Anthropic (Claude), Google Gemini, Amazon Bedrock, and Ollama. The toolkit keeps full compatibility with the underlying Microsoft Agent Framework while dramatically cutting down the code required to configure models, instructions, tool calling, reasoning effort, and MCP server integration.

## Key Features

- Provider-specific wrappers (OpenAI, Azure OpenAI, Anthropic, Google Gemini, Amazon Bedrock, Ollama) that expose advanced options without losing MAF compatibility
- `AIToolsFactory` for creating tools from plain C# classes or MCP servers with minimal ceremony
- `BatchRunner` for parallel prompt execution and `EmbeddingFactory` for embedding generation
- Tool-calling middleware support and configurable reasoning effort per provider

## Relevance to AI-Driven Development

Developers adopting Microsoft Agent Framework for agentic .NET applications will find this toolkit essential for cutting through MAF's intentional genericity when targeting specific LLM providers. It accelerates multi-provider agent development and MCP tool integration, aligning directly with the agentic AI workflow patterns documented in this toolkit.
