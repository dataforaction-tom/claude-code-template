# Project: [Name]

[One-line description of what this is and what it does]

## Architecture

- `src/` — [what lives here]
- `public/` — [static assets, etc.]
- `lib/` — [shared utilities]
- [Add key directories as they emerge]

## Commands

- `npm run dev` — start development server
- `npm test` — run tests
- `npm run build` — production build
- `npm run lint` — check for issues

## Standards

- [Framework-specific conventions]
- [Testing expectations — e.g. "write tests for all new functions"]
- [Naming conventions]

## Verification

Claude should verify its own work. For this project:
- Run `npm run build` after structural changes to confirm nothing breaks
- Run `npm run lint` before considering any task complete
- If tests exist, run `npm test` after changes to tested code
- [Add project-specific verification steps as they emerge]

## Working Rules

- Always check for existing patterns before creating new ones
- Prefer small, incremental changes over big rewrites
- If a task will take more than ~50 lines of changes, use plan mode first
- Don't add dependencies without asking
- Don't refactor code that wasn't part of the task
- Don't create files without explaining what and why

## State & Progress

> Updated: [date]
> Current focus: [what we're working on]
> Status: [where things stand]

See PLAN.md for task tracking, STATE.md for system state, HANDOFF.md for session notes.

## Known Issues

- [Things that are broken or incomplete]
- [Workarounds currently in place]

## Lessons Learned

Things Claude has got wrong on this project — don't repeat these:

- [Add mistakes as they happen — this is the highest-leverage section]

<!-- 
Keep this file concise. ~150 instructions max before Claude starts ignoring things.
If Claude already does something correctly without being told, don't add it here.
Focus on: things Claude gets wrong, patterns it can't infer, commands it needs.
-->
