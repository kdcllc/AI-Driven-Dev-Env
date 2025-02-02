# AI Driven Developer Environment for Ubuntu Linux

## `aider-chat`

## `pipx` isolated apps and environments manager

## `poetry` dependency manager

## `pyenv` python version manager

## `gptme` llm local agent

[`gptme` llm local agent](https://github.com/ErikBjare/gptme)

```bash
    pipx install 'gptme[browser]'
    # We need to use the same version of Playwright as the one installed by gptme
    # when downloading the browser binaries. gptme will attempt this automatically
    PW_VERSION=$(pipx runpip gptme show playwright | grep Version | cut -d' ' -f2)
    pipx run playwright==$PW_VERSION install chromium-headless-shell
    
    # On Ubuntu
    sudo apt install lynx
    
    # on wsl i had to 
    # sudo apt-get install python3-dev in order for the rag to be successful
    pipx install gptme-rag

    # run 
    gptme -m azure/gpt-4o

    OPENAI_BASE_URL="http://127.0.0.1:11434/v1" gptme 'hello' -m local/llama3.2:latest

    # remove logs
    rm -rf  ~/.local/share/gptme
    rm -rf ~/.cache/gptme/rag 
```
