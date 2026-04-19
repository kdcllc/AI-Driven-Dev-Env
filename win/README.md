# Windows 11 Developer Setup

Tools and reference for Windows-based development. This repo focuses on Linux, but Windows 11 with WSL2 or native tools is supported.

## Python on Windows

Not all Python versions run on Windows. Use the official installer or the Python launcher.

**Installation:**
- Download from [python.org](https://www.python.org/downloads/)
- Or use Microsoft Store (simpler, but may have limitations)

**Installed location:** `%USERPROFILE%\AppData\Local\Programs\Python`

**Launcher:** Use `py.exe` to manage multiple versions:

```powershell
# Check Python 3.8 version
py -3.8 --version

# Upgrade pip for Python 3.8
py -3.8 -m pip install -U pip
```

**Popular versions:**
- [Python 3.11.9](https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe)
- [Python 3.10.10](https://www.python.org/ftp/python/3.10.10/python-3.10.10-amd64.exe)
- [Python 3.8.10](https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe)

**Learn more:** [What is py.exe?](https://learn.microsoft.com/en-us/windows/python/faqs#what-is-py-exe-)

## Using pipx

For isolated tool installation (Python 3.11+ recommended):

```powershell
# Install pipx
py -3.11 -m pip install --user pipx

# Use pipx to install tools like aider, gptme, etc.
pipx install aider-chat
```

## Next Steps

- For Linux setup: See [README.md](../README.md) and [linux/README.md](../linux/README.md)
- For AI development: See [articles.md](../articles.md) for learning resources
- For related projects: See [code.md](../code.md)
