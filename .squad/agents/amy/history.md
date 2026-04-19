# Amy — History

## Latest Session: 2026-06-26 Content Intake Cleanup (Leela's Approved Items)

Executed three non-blocking cleanup tasks approved by Leela:

1. **Deleted CONTENT_INTAKE_FIX_VALIDATION.md** — Validation checklist for the completed fix, no longer needed in the repo
2. **Removed unused `COPILOT_TOKEN` env var** — Was defined but never used in the script; token is passed via `github-token` parameter
3. **Kept useful setup docs** — Retained `CONTENT_INTAKE_SETUP.md` (current setup guide) and `.github/templates/README.md` (template disambiguation)

**Outcome:** Branch is now clean and ready for merge. No stale or contradictory docs remain.

**Status:** Complete. Changes committed to `feat/automatic-repo-summurization`.

---

## Session: 2026-06-26 Content Intake Workflow Hardening

Fixed three critical issues in content-intake.yml after Leela's rejection of Bender's implementation:

1. **Secret fallback:** Added `secrets.GITHUB_TOKEN` fallback for `COPILOT_ASSIGN_TOKEN` to enable zero-config mode
2. **Label availability:** Proactively ensure `squad:copilot` label exists before using it (no dependency on label sync timing)
3. **Template clarity:** Removed contradiction between `articles/.template.md` (for automated intake) and `.github/templates/ARTICLE_TEMPLATE.md` (for manual curation)

Created documentation:
- `.github/templates/README.md` — Disambiguates template purposes
- `.github/workflows/CONTENT_INTAKE_SETUP.md` — Setup guide for zero-config vs full automation modes

**Key principle:** Workflows should fail gracefully and work in zero-config mode by default, with progressive enhancement when secrets are available.

**Status:** Implementation complete, decision logged to inbox.

---

## Learnings

### Workflow Design Patterns (2026-06-26)

**Zero-config by default, progressive enhancement:**
- Never hard-require secrets — always provide a fallback path
- Make automation work with `GITHUB_TOKEN` if possible
- Degrade gracefully with clear messaging when features are unavailable
- Document setup requirements explicitly instead of implying them

**Defensive label handling:**
- Don't assume labels exist, even if label sync ran
- Create labels on-demand when workflows need them
- Check roster markers (`🤖 Coding Agent`) before creating labels
- Combine on-demand creation with scheduled sync for resilience

**Template organization:**
- Separate templates by purpose and audience (automation vs manual editing)
- Use location to signal intent (`.github/templates/` for guidelines, `{dir}/.template.md` for automation)
- Add README files to disambiguate when multiple template sets exist
- Keep workflow references and actual template paths in sync

---

## Session: 2026-04-19 Platform Documentation Alignment

Updated linux/README.md with step-by-step setup flow (pyenv → pipx → poetry) and `run-aider.sh` bootstrap. Rewrote linux/aider-chat.md for clarity with environment variable reference, local vs Azure workflows, and troubleshooting. Aligned all platform docs with run-aider.sh entry point and Squad context.

**Status:** Implementation complete, decisions merged.

---

[Previous work retained for continuity]
