---
name: add-setup-guide
description: "Add a Linux setup guide for a tool: linux/<tool>.md, optional idempotent install script, and a linux/README.md entry."
argument-hint: "Tool name, e.g. poetry"
agent: agent
---

Add a Linux setup guide for the tool `${input:tool:Tool name}` to this repo.

## 1. Write the guide

Create `linux/<tool>.md`, using `linux/pyenv.md` as the model: a title line with the tool name and a short purpose, links to the upstream project and command docs, numbered install steps with fenced `bash` blocks, then a short "Some usages" block of common commands. Keep it concise and accurate; verify commands against the tool's official documentation rather than guessing.

## 2. Optional install script

If the install is scriptable, add a paired `linux/scripts/install_<tool>.sh` (see `linux/scripts/install_pyenv.sh` for the style). It must be idempotent: safe to re-run, skipping steps already done (check for the binary or the shell-profile line before installing or appending). It must contain no secrets. Check syntax with `bash -n linux/scripts/install_<tool>.sh`.

## 3. Register the guide

Add the guide to `linux/README.md`: a row in the Quick Reference table linking `./<tool>.md`, and a section or mention in the flow where it fits.

## 4. Verify

Finish by running `bash scripts/verify.sh` and fix any failure caused by your changes.
