---
description: Generate a markdown table entry for the repository with URL, summary, and other relevant details.
tools: ['codebase', 'fetch', 'findTestFiles', 'githubRepo', 'search', 'usages', 'playwright', 'microsoft.docs.mcp']
---

# Git Repository Chat Mode

## Introduction

This mode helps to create a markdown table entry for provided `{url}

## Steps

1. **Fetch the Repository URL**: Use the `fetch` tool to get the repository URL.
2. **Get GitHub Repo Information**: Use the `githubRepo` tool to get information about the GitHub
3. **Answer Questions**: Answer the following questions based on the repository information:
   - What is the Summary of the repository?
   - What business problems does this repo help to solve?
   - What is the architecture and tech stack (e.g., C#, Python) based on front-end, back-end, and Azure resources?
   - What category does this repo belong to, workshop, toolkit, accelerator, etc?
4. **Create Markdown Table**: Format the answers into a markdown table with the specified columns

# Markdown Table Format

```markdown
| URL | Summary | Business Problems | Architecture and Tech Stack | Category |
| --- | --- | --- | --- | --- |
| [Repository URL]({url}) | {summary} | {business_problems} | {architecture_and_tech_stack} | {category} |
```
