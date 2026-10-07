# the-architect

The Architect planning-and-oversight skill for AI coding agents: plan honestly, delegate precisely, verify coldly. Investigates with live evidence, decomposes work into parallel-safe milestones, tracks progress across sessions, and finds issues before they compound.

Documentation
- The full skill is `SKILL.md` (bootstrap stub — see Installation).
- The installed skill lives in `dream-orchestrator` and covers laws, investigation, P0 planning, prompt anatomy, dispatcher verification, and close.

Installation
```powershell
# Option 1: copy the architect/ folder into your environment's skills folder,
# e.g. <env>/.agents/skills/architect/ (keeping SKILL.md + INSTALL.ps1 together)
# Option 2: clone this repo and copy from the checkout
git clone https://github.com/bloomstick/the-architect.git
```

Requirements: an agent host with skill support, Windows PowerShell 5.1 for `INSTALL.ps1`, `git`, and network access to `github.com/bloomstick/dream-orchestrator` on first run.

Usage
Start a session, greet, and follow the skill — the stub installs the real one on first contact:

```text
You: Hello, Architect. I need episode lists that never lie about licensing.

Agent: Acknowledged — one line, then restating back: you want per-title
playability truth (blocked vs licensed vs open) with honest empty states.
Confirm? (stops here — nothing executes in the greeting turn)

You: Confirmed. Go investigate.

Agent: [reads code, probes live APIs, cites file:line evidence]
Plan: 3 milestones (disjoint touch sets) with gates... approve?
```

On approval the Architect fires six-section prompts (base pinned, scope, forbiddens, acceptance with named suites, landing procedure), tracks the board across sessions, verifies each landing read-only, and closes with silence proofs. Full behavior in `SKILL.md` (post-install).

How it works
1. `INSTALL.ps1` provisions the Orchestrator export beside the skill (idempotent; records revision; no `.git`, just working files).
2. The installed skill takes over: laws (evidence first, ask on ambiguity, caveats always), P0 baseline, milestone decomposition with disjoint touch sets and sequential landing, dispatcher verification tiers.
3. Implementers work in fresh worktrees + branches, verify (`analyze` + named suites), commit, land staged; pushing `main` stays the human's manual step.

Versioning
This repo follows the orchestrator it installs: re-run `INSTALL.ps1 -Force` to re-export at the latest revision. Installed copies record their source revision; never edit an installed copy — change the source and reinstall.

Contributing
Please share bug reports and feature requests through GitHub issues.

License
To be decided.
