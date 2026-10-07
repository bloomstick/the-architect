---
name: architect
description: Bootstrap for the Architect planning-and-oversight skill. On "Hello, Architect", run INSTALL.ps1 beside this file, then load and follow the installed skill instead of this stub. Never plan from this stub alone.
---

# architect (bootstrap stub — not the skill)

This file is a trigger, not the skill. On any architect-session greeting:

1. Run `INSTALL.ps1` beside this file (it provisions the orchestrator
   export; safe to re-run — existing installs report their revision).
2. Read `.orchestrator/.agents/skills/architect/SKILL.md` (relative to this
   directory) and follow it **instead of this file** for the rest of the
   session — activation, laws, planning, prompts, dispatcher loop, close.
3. If step 1 fails, report the failure verbatim and stop. Never improvise
   the skill from memory; never plan from this stub.
