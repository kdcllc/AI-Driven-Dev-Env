# Content Intake Workflow Setup

This document explains how to set up the automated content intake system.

## Zero-Config Mode (Manual Assignment)

The content intake workflow works **without any secrets** configured. When an issue is labeled with `content:article` or `content:repo`:

1. ✅ The workflow parses the issue and posts detailed instructions
2. ✅ It adds the `squad:copilot` label (if `@copilot` is in `.squad/team.md`)
3. ⚠️ A maintainer must manually assign `@copilot` to the issue

**This mode requires no setup** — just label the issue and assign `@copilot` by hand.

## Full Automation Mode (Auto-Assignment)

To enable **automatic assignment** of the Copilot coding agent, configure:

### 1. Repository Secret: `COPILOT_ASSIGN_TOKEN`

Create a GitHub token with these permissions:
- `issues: write` (to assign the agent)
- `contents: read` (to read the repo)

Add it to your repository secrets as `COPILOT_ASSIGN_TOKEN`.

### 2. Verify Team Roster

Ensure `.squad/team.md` includes the Copilot coding agent with the `🤖 Coding Agent` marker:

```markdown
## Coding Agent

| Name | Role | Charter | Status |
|------|------|---------|--------|
| @copilot | Coding Agent | — | 🤖 Coding Agent |
```

### 3. Sync Labels

After updating `team.md`, run the label sync workflow:

```bash
gh workflow run sync-squad-labels.yml
```

Or push a change to `.squad/team.md` to trigger it automatically.

## How It Works

### Content Intake Flow

```mermaid
graph TD
    A[User creates issue] --> B{Label applied?}
    B -->|content:article or content:repo| C[Workflow triggered]
    C --> D[Parse issue body]
    D --> E[Ensure labels exist]
    E --> F{@copilot on team?}
    F -->|Yes| G{COPILOT_ASSIGN_TOKEN set?}
    F -->|No| H[Post instructions only]
    G -->|Yes| I[Auto-assign @copilot]
    G -->|No| J[Post instructions + manual assign note]
    I --> K[@copilot creates summary]
    J --> L[Maintainer assigns @copilot]
    L --> K
```

### Label Sync Flow

The `sync-squad-labels.yml` workflow runs:
- On push to `.squad/team.md` or `.ai-team/team.md`
- On manual trigger via `workflow_dispatch`

It creates labels for:
- Each squad member: `squad:{name}`
- Copilot (if `🤖 Coding Agent` is present): `squad:copilot`
- Static labels: `go:*`, `release:*`, `type:*`, `priority:*`, `content:*`

## Troubleshooting

### "squad:copilot label does not exist"

**Fix:** The content intake workflow now ensures this label exists if `@copilot` is in the roster. If it still fails:

1. Check `.squad/team.md` includes `🤖 Coding Agent`
2. Run: `gh workflow run sync-squad-labels.yml`
3. Verify label exists: `gh label list | grep copilot`

### "Automatic assignment failed"

**Cause:** `COPILOT_ASSIGN_TOKEN` is not configured or lacks permissions.

**Fix:** 
- **For manual mode:** Just assign `@copilot` to the issue by hand
- **For automation:** Add the secret with `issues: write` permission

### "Could not find a URL in this issue"

**Cause:** The issue body doesn't match the expected format.

**Fix:** Use the issue templates in `.github/ISSUE_TEMPLATE/`:
- `content-article.yml`
- `content-repo.yml`

## Related Files

- **Workflow:** `.github/workflows/content-intake.yml`
- **Label Sync:** `.github/workflows/sync-squad-labels.yml`
- **Team Roster:** `.squad/team.md`
- **Issue Templates:** `.github/ISSUE_TEMPLATE/content-*.yml`
- **Content Templates:** `articles/.template.md`, `repos/.template.md`
