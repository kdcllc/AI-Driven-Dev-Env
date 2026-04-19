# open-webSearch

- **URL:** https://github.com/Aas-ee/open-webSearch
- **Owner:** Aas-ee
- **Language:** TypeScript
- **Stars:** ~200
- **Date Added:** 2026-04-19
- **Category:** RAG & Search

## Summary

open-webSearch is an MCP server, CLI, and local daemon that enables multi-engine web search and content retrieval without requiring any API keys or authentication. It aggregates results from multiple search engines including Bing, DuckDuckGo, Brave, Exa, Baidu, CSDN, Juejin, and Startpage, returning structured results with titles, URLs, and descriptions. It also supports fetching article content from specific platforms and generic web pages.

## Key Features

- Multi-engine search (Bing, DuckDuckGo, Brave, Exa, Baidu, CSDN, Juejin, Startpage) with no API keys required
- MCP server mode for integration with Claude Desktop, Cursor, and other MCP clients
- CLI and local HTTP daemon modes for one-shot and long-lived usage
- HTTP proxy support for accessing restricted resources
- Content fetching for CSDN articles, GitHub READMEs, and generic web/Markdown pages
- Optional Playwright-powered browser fallback for Bing searches

## Relevance to AI-Driven Development

Enables agentic AI systems to perform live web search and retrieve up-to-date information without vendor API keys, making it ideal for RAG pipelines, research agents, and developer tooling that need broad internet access on restricted networks.
