# Squad Decisions

## Active Decisions

### Decision: Linux Setup Documentation Restructure
**Date:** 2026-06-26  
**Owner:** Amy (Platform Engineer)  
**Status:** Implemented

**Key Changes:**
- Converted linux/README.md from heading list to step-by-step setup guide
- Rewritten linux/aider-chat.md for clarity with environment variables and local vs remote workflows
- Set `run-aider.sh` as primary bootstrap entry point
- Added Squad context and advanced tools documentation

**Design Principles:** Bootstrap-first approach, local vs remote separation, auto-generated config clarity.

---

### Decision: Agentic AI Documentation & Squad Integration
**Date:** 2026-04-19  
**Owner:** Farnsworth (AI/Context Engineer)  
**Status:** Implemented

**Key Changes:**
- Updated ai-coding.md with strengthened context engineering guidance
- Updated .github/copilot-instructions.md with Squad positioning and team structure
- Integrated Squad as Copilot-based orchestration layer (alpha, human-led)
- Added three-layer context engineering model (explicit rules, project knowledge, validation)

**Philosophy:** Context is code. Squad members own different toolkit parts. Clear charters reduce context thrashing.

---

### Decision: Documentation Refresh - Agentic AI Toolkit Reframe
**Date:** 2026-04-19  
**Owner:** Hermes (Technical Writer)  
**Status:** Implemented

**Files Updated:** README.md, CONTRIBUTING.md, articles.md, code.md, win/README.md

**Key Changes:**
- Reframed repo as documentation-first toolkit for agentic AI development
- Integrated Squad positioning naturally throughout documentation
- Streamlined contributor guidance with Squad patterns
- Elevated Squad context in code.md as human-led orchestration approach
- Maintained docstring-first culture across all files

**Philosophy:** Reduced personal branding clutter, elevated Squad without overstatement, sharpened voice for clarity.

---

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction
