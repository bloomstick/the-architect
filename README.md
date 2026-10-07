# The Architect

Meet the Architect: a planning-and-oversight skill for AI coding agents.
Instead of jumping straight into code, the Architect investigates first,
makes a plan you approve, breaks the work into small independent milestones,
watches other agents implement them, and verifies every landing before
calling anything done.

In short: you describe what you want, the Architect figures out how to get
there safely, and nothing lands without proof.

## What lives here

- `architect/SKILL.md` — the trigger. Greet any capable agent with
  "Hello, Architect" and this file takes over the session.
- `architect/INSTALL.ps1` — the setup helper. On first greeting it fetches
  the full skill and workflow from its home repository, so this little
  package stays small while the real machinery lives where it is maintained.
- This README — the human introduction you are reading now.

## Getting started

You need three things: an agent environment that supports skills (OpenCode
works), Windows PowerShell 5.1 (only for the one-time setup script), and
`git` with internet access for the first run.

**Step 1.** Give the skill to your agent. Copy the whole `architect/`
folder into your environment's skills directory — for example,
`<env>/.agents/skills/architect/` — so that `SKILL.md` and `INSTALL.ps1`
stay side by side.

**Step 2.** Start a session and say hello:

```text
You: Hello, Architect. I need episode lists that never lie about licensing.

Agent: Acknowledged — one line, then restating back: you want per-title
playability truth (blocked vs licensed vs open) with honest empty states.
Confirm? (stops here — nothing executes in the greeting turn)

You: Confirmed. Go investigate.

Agent: [reads the code, probes the live APIs, cites file and line evidence]
Plan: 3 milestones (independent work areas) with checks for each... approve?
```

**Step 3.** Approve the plan, and the Architect takes it from there: each
milestone becomes a precise work order for an implementer agent (exact
starting point, what may change, what must never change, how to prove it
works). The Architect tracks every workstream on a visible board, verifies
each landing against the repository itself, and closes the loop only when
everything is proven — with a report that always says what *wasn't* verified,
so surprises have nowhere to hide.

## How it works behind the scenes

- **Investigate before proposing.** No plan from memory — the Architect reads
  code, runs small probes against live behavior, and labels anything unproven
  as a hypothesis, never a fact.
- **Small milestones, safe landings.** Work is split so independent pieces can
  run in parallel, but landings happen strictly one at a time through a merge
  queue. Pushing to `main` always stays a human manual step.
- **Honesty over optimism.** The Architect is instructed to disagree with you
  when the evidence does, to ask whenever a decision has two readings, and to
  surface hard truths instead of comfortable agreement.
- **Nothing runs past shipping.** When a task is done — merged, verified,
  reported — every worker stops. There are no background services, no
  schedulers, nothing that could act while you aren't watching.

## The full skill

This repository is only the doorway. The complete skill — laws,
investigation method, planning, prompt shapes, progress tracking, close
procedure — is maintained in
[dream-orchestrator](https://github.com/bloomstick/dream-orchestrator),
which `INSTALL.ps1` fetches automatically on first greeting. You never need
to update this package by hand; re-running the installer picks up the latest
revision.

## Contributing

Found a rough edge or a missing explanation? Please share bug reports and
feature requests through GitHub issues — they are the project's to-do list
and its memory.

## License

MIT — see [LICENSE](LICENSE). You are free to use, copy, modify, and share
this skill, including commercially.
