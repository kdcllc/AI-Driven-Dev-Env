# Aider Chat: AI Pair Programming

[**Aider Chat** documentation](https://aider.chat/)

Aider is a command-line tool that brings an AI pair programmer into your editor and version control workflow. It understands your codebase, edits files collaboratively, and commits changes with AI-generated messages.

## Installation

Install via `pipx` (recommended for isolation):

```bash
pipx install aider-chat
```

Verify installation:
```bash
aider --version
```

## Quick Start with Local Models (Ollama)

### Using the Bootstrap Script

The simplest way to get started locally is to run the bootstrap script from the repo root:

```bash
cd /path/to/AI-DrivenDevEnv
chmod +x run-aider.sh
./run-aider.sh
```

This script automatically:
1. Installs Ollama (if not already installed)
2. Pulls two models:
   - `qwen2.5-coder:14b` – Main model (larger, better quality)
   - `qwen2.5-coder:0.5b` – Weak model (smaller, for commits and summarization)
3. Creates `.aider.model.settings.yml` with model parameters
4. Creates `.aider.conf.yml` with recommended configuration
5. Sets environment variables (`OLLAMA_API_BASE`, `AIDER_EDITOR`)
6. Launches aider

### Manual Setup

If you prefer manual control or need to troubleshoot:

```bash
# Ensure Ollama is running
ollama serve &

# Set the Ollama endpoint
export OLLAMA_API_BASE=http://127.0.0.1:11434

# Pull models (if not already present)
ollama pull qwen2.5-coder:14b
ollama pull qwen2.5-coder:0.5b

# Launch aider with a specific model
aider --model ollama_chat/qwen2.5-coder:14b --editor-edit-format whole
```

## Configuration Files

Aider respects configuration in two files. **Run `./run-aider.sh` to auto-generate these**, or create manually:

### `.aider.model.settings.yml`

Defines per-model parameters:

```yaml
- name: ollama_chat/qwen2.5-coder:14b
  extra_params:
    num_ctx: 8192
- name: ollama_chat/qwen2.5-coder:0.5b
  extra_params:
    num_ctx: 8192
```

### `.aider.conf.yml`

Main configuration file (see [full docs](https://aider.chat/docs/config/aider_conf.html)):

```yaml
# Main model for code generation
model: ollama_chat/qwen2.5-coder:14b

# Weak model for commits and summarization
weak-model: ollama_chat/qwen2.5-coder:0.5b

# Edit format: "whole" (replace entire file) or "diff" (apply patches)
# editor-edit-format: whole

# Tokens allocated for repo map (context about your codebase). 0 disables.
# map-tokens: 8192

# Repo map refresh strategy: auto, always, files, or manual
map-refresh: auto
```

## Environment Variables

### Key Variables

| Variable | Purpose | Example | Where It's Set |
|----------|---------|---------|-----------------|
| `OLLAMA_API_BASE` | Ollama server endpoint | `http://127.0.0.1:11434` | `.aider.conf.yml` or shell |
| `AIDER_EDITOR` | Editor command for edits | `code --wait` | `run-aider.sh` (shell export) |
| `AZURE_API_KEY` | Azure OpenAI API key | (your key) | `~/.bashrc` (via `aider-az-setup.sh`) |
| `AZURE_API_VERSION` | Azure OpenAI API version | `2024-10-01-preview` | `~/.bashrc` (via `aider-az-setup.sh`) |
| `AZURE_API_BASE` | Azure OpenAI endpoint | `https://*.openai.azure.com/` | `~/.bashrc` (via `aider-az-setup.sh`) |

**Tip:** Store variables in `.env` (project root) or `~/.bashrc` for persistence. Aider will read `.env` automatically.

## Running Aider

### With Local Ollama (Default)

```bash
# Simple: uses config in .aider.conf.yml
aider

# Explicit: specify model on command line
aider --model ollama_chat/qwen2.5-coder:14b --editor-edit-format whole

# With other Ollama models
aider --model ollama_chat/deepseek-coder-v2
aider --model ollama_chat/llama3.2:latest
```

### With Azure OpenAI

First, set up your Azure credentials:

```bash
./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>
source ~/.bashrc
```

Then run:

```bash
# Use the alias created by the setup script
aider-az  # Runs: aider --model azure/gpt-4o --dark-mode

# Or explicitly
aider --model azure/gpt-4o --dark-mode --subtree-only
```

### With VS Code Integration

Install the [Aider VS Code extension](https://marketplace.visualstudio.com/items?itemName=MattFlower.aider) for integrated workflows.

## Available Models

### Local (Ollama)

All require `OLLAMA_API_BASE=http://127.0.0.1:11434`:

- `ollama_chat/qwen2.5-coder:14b` – Recommended (balanced speed/quality)
- `ollama_chat/qwen2.5-coder:3b`, `0.5b` – Lightweight alternatives
- `ollama_chat/deepseek-coder-v2` – Alternative (good code reasoning)
- `ollama_chat/llama3.2:latest` – Alternative (more general)

### Remote (Azure OpenAI)

Requires Azure credentials:

- `azure/gpt-4o` – Recommended for production
- `azure/gpt-4-turbo`
- `azure/gpt-35-turbo`

## Common Workflows

### Start a coding session in a repo

```bash
cd my-project
aider
```

Aider will discover your project structure and be ready to help. Type your request (e.g., "Add a function to validate emails") and aider will suggest changes.

### Use a smaller model for quick edits

```bash
aider --model ollama_chat/qwen2.5-coder:0.5b
```

### Disable auto-commit (review changes first)

```bash
aider --no-auto-commits
# Or set in .aider.conf.yml:
# auto-commits: false
```

### Work on a subtree only (faster, less context)

```bash
aider --subtree-only src/
```

## Troubleshooting

### Aider cannot reach Ollama

**Error:** `Connection refused` or `Cannot connect to Ollama`

**Fix:**
```bash
# Ensure Ollama is running
ollama list  # Should display installed models

# Check the endpoint
export OLLAMA_API_BASE=http://127.0.0.1:11434

# Try a direct request
curl -s http://127.0.0.1:11434/api/tags | head -20
```

### Model takes too long to respond

Lower context or use a smaller model:

```bash
aider --model ollama_chat/qwen2.5-coder:0.5b
```

Or reduce `num_ctx` in `.aider.model.settings.yml`.

### Changes not reflected in editor

Ensure `AIDER_EDITOR` is set correctly:

```bash
export AIDER_EDITOR="code --wait"  # VS Code
# or
export AIDER_EDITOR="vim"  # Vim
```

## Next Steps

- Read [Aider documentation](https://aider.chat/docs/)
- Explore `.aider.conf.yml` options for advanced configuration
- See [linux/README.md](./README.md) for the full platform setup flow