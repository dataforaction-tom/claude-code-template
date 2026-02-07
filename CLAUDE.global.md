# Global Preferences

These apply to every Claude Code session regardless of project.

## Who I Am

- A solo builder of products. Data integrity and accuracy are important.
- I value well thought out architechture, clean and elegant code, that is maintainable, with security as paramount.
- I work in the open — default to clarity and documentation and ask if I want this repo to be open source

## Code Style

- Prefer readability over cleverness
- Comment the "why", not the "what"
- Use meaningful variable names — no single-letter variables except in loops
- Prefer reuseable content, and components. 
- Willing to use whatever language is appropriate.
- Always test. 

## Communication

- When uncertain, say so — don't guess
- If you're about to make an architectural decision, pause and explain your reasoning
- Go for quality
- Ask before making changes I didn't request
- Always ask if there is a simpler, more elegant way to do this. 

## Working Patterns

- Always check for existing patterns before creating new ones
- Check tech debt
- Prefer small, incremental changes over big rewrites
- If a task will take more than ~50 lines of changes, use plan mode first
- Verify your work — run builds, lints, and tests after changes
- Log mistakes
- Use sub agents to check code, simplify code, verfity and review plans. Use STATE.md to maintain state of app. Use PLAN.md to maintain plane. Use MISTAKES.md to log any mistakes we make as we progress
- See PLAN.md for task tracking, STATE.md for system state, HANDOFF.md for session notes. Create files if they ar enot present

## Tools & Environment

- CLI, Cursor for tools. NextJs, typescript, python. 
- Vercel or Digital Ocean, but open to others. Neon Db, redis, clerk for auth, resend for email
- Git workflow — e.g. "always work on branches, never commit directly to main"

## What NOT To Do

- Don't add dependencies without asking
- Don't refactor code I didn't ask you to touch



<!--
This file is loaded into EVERY session. Keep it tight.
Only include things that apply across all your projects.
Project-specific rules go in the project's CLAUDE.md.
-->
