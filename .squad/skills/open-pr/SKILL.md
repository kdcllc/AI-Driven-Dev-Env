---
name: "open-pr"
description: "Publish an existing branch safely by checking branch state, syncing it, and creating or reusing a pull request."
domain: "workflow-automation"
confidence: "high"
source: "earned"
tools:
  - name: "gh"
    description: "Inspect pull requests, push branches, and create PRs from the CLI."
    when: "Use when a branch already exists locally and you need to publish or reuse a PR."
---

## Context
Use this when a branch already contains the intended work and the job is to get it reviewed without rewriting history. It is especially useful for automation-heavy branches where the safest move is to verify state, push once, and avoid duplicate PRs.

## Patterns
- Start with `git status --short --branch` to confirm whether there are uncommitted changes.
- Check whether the remote branch exists and whether local and remote SHAs match before pushing.
- Look for an existing PR with `gh pr list --head <branch>` before creating a new one.
- Create the PR only after the branch is pushed so reviewers see the exact remote tip.
- Summarize workflow behavior, fallback behavior, and affected files in the PR body instead of making reviewers reconstruct it from the diff.

## Examples
- `git rev-parse HEAD && git rev-parse origin/<branch>` to detect whether a push is needed.
- `gh pr list --head feat/automatic-repo-summurization --json number,title,url`
- `gh pr create --base master --head feat/automatic-repo-summurization --title "<title>" --body-file <file>`

## Anti-Patterns
- Do not amend or reorder existing commits just to publish the branch.
- Do not create a new PR until you have checked whether one already exists.
- Do not open the PR before pushing the latest local commits.
