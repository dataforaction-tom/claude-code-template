# Skills

Skills are markdown-based guides that teach Claude how to handle specific tasks. Unlike slash commands (which you invoke explicitly), skills are invoked via natural language — Claude decides when to use them.

## When to Create a Skill

If you do something more than once a day, consider turning it into a skill or command.

## How to Create a Skill

Create a `SKILL.md` file in a subdirectory here:

```
.claude/skills/
├── my-skill-name/
│   └── SKILL.md
```

The SKILL.md should explain:
- When to use this skill (triggers)
- Step-by-step instructions
- Examples of good output
- Common mistakes to avoid (the "Failed Attempts" section is often the most valuable part)

## Example

```markdown
# Deployment Skill

## When to Use
When the user asks to deploy, ship, or push to production.

## Steps
1. Run the test suite
2. Run the build
3. Check for uncommitted changes
4. Deploy using `vercel --prod`
5. Verify the deployment is live

## Failed Attempts
- Don't use `vercel` without `--prod` — it creates a preview deployment
- Don't deploy without running tests first — we've shipped broken builds this way
```

Commit skills to git so they travel with the project.
