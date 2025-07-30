# AI assisted coding

## What is Context Engineering?

[Context Engineering](https://github.com/coleam00/context-engineering-intro) represents a paradigm shift from traditional prompt engineering:

### Prompt Engineering vs Context Engineering

**Prompt Engineering:**

- Focuses on clever wording and specific phrasing
- Limited to how you phrase a task
- Like giving someone a sticky note

**Context Engineering:**

- A complete system for providing comprehensive context
- Includes documentation, examples, rules, patterns, and validation
- Like writing a full screenplay with all the details

### Why Context Engineering Matters

1. **Reduces AI Failures**: Most agent failures aren't model failures - they're context failures
2. **Ensures Consistency**: AI follows your project patterns and conventions
3. **Enables Complex Features**: AI can handle multi-step implementations with proper context
4. **Self-Correcting**: Validation loops allow AI to fix its own mistakes



## GitHub Copilot

[Awesome Copilot templates](https://github.com/github/awesome-copilot)

- **[Customer Instructions](https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-instructions)** : Define common guidelines for tasks like code generation, reviews, and commit messages. Describe how tasks should be performed. Note: Custom instructions only affect Copilot Chat (not inline code completions).

### Prompt Files

Prompt files are reusable Markdown files (with `.prompt.md` extension) that define prompts for common tasks such as code generation, code review, or automation. They can include metadata (like mode, model, tools) and reference other files. Prompt files can be stored in `.github/prompts` (workspace) or in your user profile, and can be run directly in chat or attached to chat sessions. Use prompt files to:

- Standardize how tasks are described to Copilot
- Reference custom instructions for consistency
- Organize prompts by topic or workflow
See: [Prompt files (experimental)](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-files-experimental)

### Modes

Modes define how Copilot chat operates:

- **ask**: Standard Q&A or code generation
- **edit**: Edit code based on instructions (e.g., refactor, fix bugs)
- **agent**: Agent mode enables Copilot to use tools, access workspace context, and perform multi-step tasks
You can specify the mode in prompt files or select it in the chat interface. Agent mode is especially powerful for automating complex workflows.

### MCP Servers

MCP (Model Context Protocol) servers extend Copilot’s capabilities by providing access to external tools, APIs, or data sources. In agent mode, Copilot can connect to one or more MCP servers to:

- Retrieve business data, documentation, or code context
- Perform actions via APIs or custom tools
- Integrate with enterprise systems
To use MCP servers, configure them in your workspace and reference them in prompt files or chat sessions. See: [MCP Servers for agent mode](https://code.visualstudio.com/insider/mcp)

### Tool Sets

Tool sets are collections of tools (such as linters, test runners, or custom scripts) that Copilot can use in agent mode. You can configure which tool sets are available in your workspace and reference them in prompt files. Tool sets enable Copilot to:

- Run code analysis or tests
- Automate repetitive tasks
- Interact with your project’s build or deployment pipeline
Configure tool sets in your workspace settings or via the chat interface for agent mode.

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