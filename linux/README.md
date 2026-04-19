# AI-Driven Developer Environment for Ubuntu Linux

This guide sets up a complete Python development environment with AI tools, emphasizing local LLM integration (Ollama) and isolated package management (pipx). Follow the recommended flow below or pick individual tools as needed.

## Recommended Setup Flow

### 1. Python Version Management (`pyenv`)

Start here to manage multiple Python versions on the same machine.

**Installation:**
```bash
curl -fsSL https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc
exec "$SHELL"
```

**Install Python and set a global version:**
```bash
# Install dependencies
sudo apt update && sudo apt install build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install Python 3.11
pyenv install 3.11:latest
pyenv global 3.11.11

# Verify
python --version
```

See [pyenv.md](./pyenv.md) for detailed commands.

### 2. Isolated Package Manager (`pipx`)

After setting a Python version with `pyenv`, install `pipx` to manage Python applications in isolated environments.

**Installation:**
```bash
sudo apt update
sudo apt install pipx
pipx ensurepath

# Optional: point pipx to a specific Python version
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.11.11/bin/python"
echo 'export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.11.11/bin/python"' >> ~/.bashrc
```

See [pipx.md](./pipx.md) for more details.

### 3. Dependency Manager (`poetry`)

Use `poetry` to manage project dependencies and create reproducible virtual environments.

**Installation:**
```bash
pipx install poetry
poetry config virtualenvs.in-project true  # Create .venv inside projects
```

**Common workflow:**
```bash
poetry new my-project
cd my-project
poetry install
poetry add requests  # Add dependencies
```

See [poetry.md](./poetry.md) for full usage.

---

## AI-Powered Coding Workflows

### Aider + Local Ollama (Recommended for Development)

**What is Aider?** A CLI tool that pair-programs with LLMs, integrating with your editor and git workflow.

**Quick Start:**
```bash
cd /path/to/your/repo
./run-aider.sh
```

This script automatically:
- Installs Ollama (if missing)
- Pulls `qwen2.5-coder:14b` and `qwen2.5-coder:0.5b` models
- Creates `.aider.model.settings.yml` and `.aider.conf.yml` config files
- Sets `OLLAMA_API_BASE=http://127.0.0.1:11434`
- Launches aider in your editor

**Manual setup (if needed):**
```bash
pipx install aider-chat
export OLLAMA_API_BASE=http://127.0.0.1:11434
aider --model ollama_chat/qwen2.5-coder:14b --editor-edit-format whole
```

**Key environment variables:**
- `OLLAMA_API_BASE`: URL to your Ollama instance (default: `http://127.0.0.1:11434`)
- `AIDER_EDITOR`: Editor command (default in script: `code --wait` for VS Code)

See [aider-chat.md](./aider-chat.md) for detailed configuration and model options.

### Aider + Azure OpenAI (Production/Paid)

For production work with Azure OpenAI:
```bash
./linux/scripts/aider-az-setup.sh <api_key> <api_version> <api_base>
source ~/.bashrc
aider-az  # Uses configured Azure endpoint
```

This sets up:
- `AZURE_API_KEY`, `AZURE_API_VERSION`, `AZURE_API_BASE` in `~/.bashrc`
- Alias `aider-az` that runs with `azure/gpt-4o`

### Squad: Multi-Agent Copilot Workflows (Alpha)

Squad is an experimental, human-led multi-agent workflow built on GitHub Copilot. It orchestrates specialized agents (e.g., Platform Engineer, Architect, Code Reviewer) to tackle complex tasks. While primarily available in the GitHub Copilot CLI, Squad patterns and templates are documented here for reference.

**When to use Squad:**
- Complex project tasks requiring multiple specialist viewpoints
- Cross-cutting concerns (docs + infrastructure + code review)
- Large refactorings that benefit from collaborative design

See `.squad/` directory in your repo root for team structure and decisions.

---

## Advanced Tools

### GPTMe: Local LLM Agent

[`gptme`](https://github.com/ErikBjare/gptme) is a conversational agent that runs code and researches topics. Install via `pipx`:

**Installation:**
```bash
pipx install 'gptme[browser]'

# Set up browser (Playwright)
PW_VERSION=$(pipx runpip gptme show playwright | grep Version | cut -d' ' -f2)
pipx run playwright==$PW_VERSION install chromium-headless-shell

# On Ubuntu, optionally install terminal browser
sudo apt install lynx

# For RAG (Retrieval-Augmented Generation)
pipx install gptme-rag  # May require: sudo apt-get install python3-dev
```

**Usage:**
```bash
# With Azure OpenAI
gptme -m azure/gpt-4o

# With local Ollama
OPENAI_BASE_URL="http://127.0.0.1:11434/v1" gptme 'hello' -m local/llama3.2:latest
```

**Clean up logs:**
```bash
rm -rf  ~/.local/share/gptme
rm -rf ~/.cache/gptme/rag
```

---

## Configuration Files

Aider and related tools respect the following config files in your project root:

- **`.aider.conf.yml`** – Main aider configuration (model, edit format, repo map settings)
- **`.aider.model.settings.yml`** – Per-model parameters (e.g., context window)
- **`.env`** – Environment variables (including `OLLAMA_API_BASE`, Azure keys)

See [aider-chat.md](./aider-chat.md) for example configs.

---

## Quick Reference

| Tool | Purpose | Install | Learn More |
|------|---------|---------|------------|
| **pyenv** | Python version manager | Curl | [pyenv.md](./pyenv.md) |
| **pipx** | Isolated Python apps | `apt` | [pipx.md](./pipx.md) |
| **poetry** | Dependency manager | `pipx install poetry` | [poetry.md](./poetry.md) |
| **aider** | AI pair programmer | `pipx install aider-chat` | [aider-chat.md](./aider-chat.md) |
| **gptme** | LLM agent & research | `pipx install gptme[browser]` | See Advanced Tools above |
| **Ollama** | Run local LLMs | Curl (automatic in `run-aider.sh`) | [open-webui.md](./open-webui.md) |

---

## Next Steps

1. **For a quick local AI coding session:** Run `./run-aider.sh` (requires Ollama)
2. **For Azure OpenAI:** Run `./linux/scripts/aider-az-setup.sh` with your credentials
3. **For multiple projects:** Use `pyenv` + `poetry` to isolate dependencies per project
4. **For team workflows:** Explore `.squad/` and configure agents for your use case
