# Claude Code Project Template

A ready-to-use project structure for working effectively with [Claude Code](https://code.claude.com). Gives you state tracking, session handoffs, a self-improving mistakes log, slash commands, and subagents — so Claude stays on track across sessions and gets better over time.

Based on best practices from [Boris Cherny](https://www.threads.com/@boris_cherny/post/DTBVlMIkpcm) (creator of Claude Code), [Anthropic's internal teams](https://www-cdn.anthropic.com/58284b19e702b49db9302d5b6f135ad8871e7658.pdf), and the wider community.

## The Problem This Solves

Claude Code starts every session with no memory. Without structure, you end up repeating context, re-explaining decisions, and watching Claude make the same mistakes across sessions. This template gives you a lightweight system for:

- **Persistent context** — CLAUDE.md files that tell Claude how your project works
- **State tracking** — plans, state diagrams, and component status that survive between sessions
- **Session continuity** — handoff documents so you can `/clear` or close a session and pick up cleanly
- **Continuous improvement** — a mistakes log that feeds back into Claude's instructions, so errors don't recur
- **Verification** — slash commands and subagents that help Claude check its own work

## Quick Start

```bash
# Clone the template (strips git history)
npx degit dataforaction-tom/claude-code-template my-new-project

# Set up
cd my-new-project
bash setup.sh
```

The setup script will:

1. Ask for your project name and description
2. Stamp today's date into the tracking files
3. Offer to install a global `~/.claude/CLAUDE.md` if you don't have one
4. Add local/temporary files to `.gitignore`
5. Optionally initialise a git repo
6. Clean up after itself (removes `setup.sh` and the global template file)

Then edit `CLAUDE.md` to fill in your project's architecture, commands, and standards, and `PLAN.md` to define what you're building.

## What's Included

```
project/
├── CLAUDE.md               ← Project config (committed to git)
├── CLAUDE.local.md         ← Personal overrides (.gitignored)
├── CLAUDE.global.md        ← Template for ~/.claude/CLAUDE.md (removed by setup.sh)
├── PLAN.md                 ← Living plan with tasks and decisions
├── STATE.md                ← State diagram and component status
├── MISTAKES.md             ← Error log and lessons learned
├── HANDOFF.md              ← Session handoff notes (.gitignored)
├── setup.sh                ← One-time setup (removes itself)
├── README.md               ← This file
└── .claude/
    ├── commands/
    │   ├── catchup.md      ← /catchup — orient yourself at session start
    │   ├── commit-push-pr.md ← /commit-push-pr — lint, test, commit, push
    │   ├── handoff.md      ← /handoff — write session notes, update tracking
    │   ├── reflect.md      ← /reflect — capture mistakes and patterns
    │   ├── review.md       ← /review — self-check against standards
    │   ├── status.md       ← /status — quick status from tracking files
    │   └── techdebt.md     ← /techdebt — find and fix safe tech debt
    ├── agents/
    │   ├── code-reviewer.md    ← Staff engineer code review
    │   ├── code-simplifier.md  ← Reduce complexity after a feature
    │   ├── plan-reviewer.md    ← Catch gaps before building
    │   └── verify-app.md       ← End-to-end verification
    └── skills/
        └── README.md       ← How to create project-specific skills
```

### Tracking Files

| File | Purpose | In git? |
|------|---------|---------|
| `CLAUDE.md` | Project architecture, commands, standards, lessons learned | Yes |
| `CLAUDE.local.md` | Your personal environment and preferences | No |
| `PLAN.md` | Tasks, decisions, open questions, scope | Yes |
| `STATE.md` | Mermaid state diagram, component status table | Yes |
| `MISTAKES.md` | What went wrong and what to do instead | Yes |
| `HANDOFF.md` | What happened last session, what's next | No |

### Slash Commands

| Command | When to use |
|---------|-------------|
| `/catchup` | Start of session — reads git changes and tracking files, tells you where things stand |
| `/status` | Quick check — what's done, in progress, and next |
| `/review` | After completing work — checks against standards and MISTAKES.md, runs lint/build |
| `/reflect` | End of session — captures mistakes and patterns, updates CLAUDE.md and MISTAKES.md |
| `/handoff` | End of session — writes handoff notes, updates PLAN.md and STATE.md |
| `/techdebt` | Housekeeping — finds and fixes safe technical debt |
| `/commit-push-pr` | Ship it — lint, build, test, commit, push, optionally create PR |

### Subagents

Subagents run in their own context window, keeping your main session clean.

| Agent | What it does |
|-------|--------------|
| `code-reviewer` | Reviews changes as a staff engineer — severity-rated findings |
| `code-simplifier` | Simplifies code after a feature is complete without changing behaviour |
| `plan-reviewer` | Reviews a plan before implementation — catches gaps, risks, over-engineering |
| `verify-app` | Runs build, lint, tests, and checks features work end-to-end |

## The Core Workflow

### Starting a session

```
/catchup
```

This reads the git diff, handoff notes, plan, and state files, then gives you a concise summary of where things stand.

### Working

For any non-trivial task, start in **plan mode** (`Shift+Tab` twice in Claude Code). Have Claude research and plan before writing code. For important plans, use the `plan-reviewer` subagent to get a second opinion before building.

If Claude makes a mistake, tell it:

> "Add what just happened to MISTAKES.md so you don't repeat it."

If something goes wrong twice, don't keep fixing — `/clear` and start fresh with a better prompt.

### Ending a session

```
/reflect
/handoff
/commit-push-pr
```

This captures learnings, writes handoff notes, updates the tracking files, and ships.

### The Improvement Flywheel

```
Mistakes → MISTAKES.md → CLAUDE.md rules → Better agent → Fewer mistakes
```

Periodically review MISTAKES.md. When a pattern recurs, promote it to a permanent rule in CLAUDE.md. Delete the promoted entry from MISTAKES.md to keep things focused.

## How the Files Fit Together

Claude Code loads CLAUDE.md files automatically at the start of every session. Here's the hierarchy:

```
~/.claude/CLAUDE.md              ← Global: your preferences across ALL projects
│
├── project/CLAUDE.md            ← Project: architecture, commands, standards (git)
│   ├── CLAUDE.local.md          ← Local: personal overrides (.gitignored)
│   └── src/api/CLAUDE.md        ← Subdirectory: loaded on-demand when working there
```

**Loading rules:**
- **Ancestors** always load at startup (Claude walks up the directory tree)
- **Descendants** load lazily (only when Claude reads files in that directory)
- **Siblings** never load (working in `frontend/` won't pull in `backend/CLAUDE.md`)

The other tracking files (PLAN.md, STATE.md, etc.) are **not** auto-loaded — they're read by the slash commands when needed, which keeps Claude's context clean.

## Key Principles

These are the patterns that consistently produce the best results:

**1. Give Claude a way to verify its work.**
This is the single most important thing. Tests, builds, lints — whatever makes sense for your project. A verification loop alone will 2–3x the quality of output.

**2. Keep CLAUDE.md concise.**
~150 instructions is the practical limit. Beyond that, Claude starts ignoring things. If Claude already does something right without being told, don't add it.

**3. Use `/clear` aggressively.**
Between unrelated tasks. After two failed corrections. Context pollution is the primary failure mode, not Claude's capabilities.

**4. Plan before you build.**
Use plan mode for every non-trivial task. For big projects, plan conversationally first (in Claude.ai or plan mode), then execute.

**5. Record mistakes immediately.**
The correction you make today prevents the same mistake tomorrow.

## Customising

This template is a starting point. As you use it:

- **Add project-specific verification** to the CLAUDE.md verification section
- **Create skills** in `.claude/skills/` for tasks you repeat daily
- **Add slash commands** in `.claude/commands/` for your common workflows
- **Push improvements back** to this template repo when you find patterns that work across projects

## Background

For the full research and rationale behind this template, see the companion guide which covers CLAUDE.md mechanics, context management, and the source material this template draws from.

## Further Reading

- [Boris Cherny's personal workflow](https://www.threads.com/@boris_cherny/post/DTBVlMIkpcm) — The creator's 13-step setup
- [Boris Cherny's team tips](https://www.threads.com/@boris_cherny/post/DUMZr4VElyb) — 10 tips from the Claude Code team
- [How Anthropic Teams Use Claude Code](https://www-cdn.anthropic.com/58284b19e702b49db9302d5b6f135ad8871e7658.pdf) — Internal case studies from 10 departments
- [Anthropic's official best practices](https://code.claude.com/docs/en/best-practices)
- [Anthropic's CLAUDE.md guide](https://claude.com/blog/using-claude-md-files)
- [The Complete Guide to CLAUDE.md](https://www.builder.io/blog/claude-md-guide) — Steve Krouse's walkthrough
- [Claude Code Best Practices compilation](https://rosmur.github.io/claudecode-best-practices/) — Community aggregation

## Licence

Do whatever you want with this. No attribution needed.
