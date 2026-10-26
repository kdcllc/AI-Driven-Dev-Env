# Model Map (resolved — Claude Code + GitHub Copilot)

Model IDs are **configuration, not constants**. This file is the single place they are
defined; re-run `/agent-kit` (or edit here and re-emit) when providers rotate model names.

**Checked 2026-10-25.** Claude Code IDs verified against the Claude Code model-configuration alias table and `claude --version` (2.1.309, above every pin's minimum). Copilot: the `<model name> (copilot)` format was verified against the VS Code custom-agent file reference, and every pinned model (`claude-opus-5.5`, `claude-sonnet-5.5`, `claude-haiku-5.5`, `grok-4.7`, `gpt-6.1-sol`) appears in the GitHub Copilot CLI 1.0.103 model catalog (`copilot help config`). Explicit `--model` selection was refused for every model on this account during the check (including the one `auto` routed to), so per-account availability was not confirmed — if a Copilot subagent does not run, check the VS Code model picker and enabled models at github.com/settings/copilot, then re-emit.

## Tier assignments

| Tier | Roles | Rationale |
|------|-------|-----------|
| `frontier` | orchestrator (main session), `evaluator`, `qa-evaluator`, `diagnostician` | Delegation and evaluation have a capability floor — don't cheap out on the roles that decide and verify; continuation-ladder diagnosis needs frontier-tier reasoning |
| `light` | `implementer`, `test-writer`, `evidence-collector` | Checklist-driven execution retains most quality at a fraction of the cost when the plan and the verification are strong |
| `fast` | `terminal` | Single-command execution and result extraction need no deep reasoning — the cheapest, quickest tier fits |

## Resolved models

| Tier | Claude Code |
|------|-------------|
| `frontier` | claude-opus-5-5 |
| `light` | claude-sonnet-5-5 |
| `fast` | claude-haiku-5-5 |

- Copilot (VS Code): frontier `Claude Opus 5.5 (copilot)`, light `Claude Sonnet 5.5 (copilot)`, fast `Claude Haiku 5.5 (copilot)`

An install that omits `fast` runs `terminal` on the light model (the `fast` row then
repeats the light ID).

Reasoning-effort pins: evaluators (`evaluator`, `qa-evaluator`) `high`, `diagnostician` `xhigh`, `implementer`/`test-writer`/`evidence-collector` `medium`, `terminal` `low` — Claude Code `effort:` frontmatter. Copilot has no effort key (dropped). Never quote the YAML `model:` value.

## Fallback chains

| Tier | Chain (first available wins) |
|------|------------------------------|
| `frontier` | Claude Code `claude-opus-5-5` → `claude-sonnet-5-5` → (omit pin — harness default); Copilot `Claude Opus 5.5 (copilot)` → (omit pin) |
| `light` | Claude Code `claude-sonnet-5-5` → `claude-haiku-5-5` → (omit pin); Copilot `Claude Sonnet 5.5 (copilot)` → (omit pin) |
| `fast` | Claude Code `claude-haiku-5-5` → `claude-sonnet-5-5` → (omit pin); Copilot `Claude Haiku 5.5 (copilot)` → `Claude Sonnet 5.5 (copilot)` → (omit pin) |

Rules (adapted from bradygaster/squad's model selector):

- **Never fall back UP a tier** — a light role must never silently land on a frontier
  model, and a frontier role never degrades below the standard rung of its chain.
  One carve-out: fast → light is allowed, because light is `terminal`'s baseline tier
  (installs without `fast` run it there).
- Fallbacks are silent to the user but **logged in the orchestration log**.
- Max 3 fallback attempts, then omit the model pin and take the harness default.
- Apply at most **one** complexity adjustment per spawn — no cascading bumps.
- **Cost ceiling policy**: an EXPLICIT human model choice above a plan/admin ceiling →
  warn loudly and honor it; an implicit (auto-selected) choice → downgrade to the
  ceiling; no compliant model at all → fail loud — never silently substitute.
- **Prompts are executable — narrowly**: only tasks that edit `templates/agents/*`
  or `templates/skills/*-criteria/*` (the files that shape every later spawn's
  behavior) use the frontier tier; skills, emitters, drivers, docs, and tests stay
  on the light tier.
- **Every spawn names its model.** The orchestrator passes the tier's resolved ID
  explicitly on every spawn and records `requested` vs the agent's self-reported
  model in the orchestration log; `inherit` is legitimate only for a tier the
  install deliberately left unpinned.

### Loop fallback chain

| Chain (first available wins) | Resolves |
|-------------------------------|----------|
| `claude-sonnet-5-5` → `claude-haiku-5-5` → (omit pin — harness default) | `claude-sonnet-5-5,claude-haiku-5-5` |

Light-tier by default; the loop drives Claude Code headless. Never use `best` or `fable` in the chain (usage-credit billing; emit rejects them).

## Fix-cycle rotation (after evaluator rejections)

A model blind to its own class of mistake rarely fixes it on retry. Rotate:

| Fix cycle | Implementer model |
|-----------|-------------------|
| 1 | Claude Code `claude-sonnet-5-5` / Copilot `Claude Sonnet 5.5 (copilot)` (normal) |
| 2 | Claude Code `claude-opus-5-5` — same-family rotation (reduced diversity); Copilot `Grok 4.7 (copilot)` (cross-family) |
| 3 | Claude Code `claude-opus-5-5` (effort `xhigh`) / Copilot `Claude Opus 5.5 (copilot)` |

**Same-family rotation.** When no different-family model at comparable tier is reachable
on a harness, fix cycle 2 may pin a different same-family model (see the table above) and
label the row `same-family rotation (reduced diversity)`. A second harness such as Copilot
or Codex provides cross-family models when targeted. Repeated same-shaped failures across
fix cycle 2 and continuation-ladder rung 4 should escalate to a human sooner.

### After cycle 3 — continuation ladder pins

When fix cycles 1–3 exhaust, the continuation ladder (see ORCHESTRATION.md) applies:

| Ladder step | Model pin |
|-------------|-----------|
| Diagnosis-driven implementation attempt (rung 4) | Claude Code `claude-opus-5-5` / Copilot `Claude Opus 5.5 (copilot)` |
| Evaluator arbitration mode (rung 5) | Claude Code `claude-opus-5-5` — same-family arbiter (reduced independence); Copilot `GPT-6.1 Sol (copilot)` (cross-family) |

**Same-family arbiter.** When no different-family frontier model is reachable on a
harness, `frontier_alt_family` may equal `frontier` with `arbiter_same_family: true`
in the answers file (emit otherwise warns); the rung-5 row is then labelled
"same-family arbiter (reduced independence)" and the arbiter's verdict header says
`same-family arbiter`. Reusing the fix-cycle-2 alternate (`alt_family`) for
arbitration stays forbidden — when `frontier_alt_family` equals `alt_family` (and
differs from `frontier`), emit warns even with the flag.

**Copilot fit:** frontier = session tier, so diagnostician and arbiter pins respect the
cost ceiling; Copilot has no effort key (drop it).

## Harness caveats that shape tiering

- **Copilot cost ceiling**: a subagent cannot run a *stronger* model than the session — run the main session on the `frontier` tier; workers pin down.
- **Copilot model names are display names** in `<model name> (copilot)` form (VS Code custom-agent file reference); an unavailable name makes the subagent fall back or not run — confirm each in the model picker.
- **Claude Code env overrides**: `CLAUDE_CODE_SUBAGENT_MODEL` and `CLAUDE_CODE_EFFORT_LEVEL` override frontmatter; org `availableModels` allowlists can cause pins to be ignored.
- **Claude Code is single-provider (Anthropic only)** — the cross-family arbiter is only reachable from Copilot.
- **Claude Code aliases resolve per provider** — full IDs are pinned. Minimum versions: Opus 5.5 ≥ v2.1.280, Sonnet 5.5 ≥ v2.1.284, Haiku 5.5 ≥ v2.1.293 (this machine: v2.1.309).
- **Usage-credit aliases**: headless loop runs must never resolve to `best`/`fable`.
