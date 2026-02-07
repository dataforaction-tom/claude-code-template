Prepare and push a clean commit. Follow these steps:

1. Run `git status` and `git diff --stat` to see what's changed
2. Run the project's lint command if one exists
3. Run the project's build command to confirm nothing is broken
4. Run tests if they exist and are relevant to the changes
5. Stage the appropriate files (don't stage unrelated changes)
6. Write a clear, conventional commit message:
   - Use format: `type(scope): description`
   - Types: feat, fix, refactor, docs, test, chore, style
   - Keep the first line under 72 characters
   - Add a body if the change needs explanation
7. Commit and push to the current branch
8. If this branch is ready for review, create a pull request with:
   - A clear title matching the commit message
   - A description of what changed and why
   - Any testing notes or things the reviewer should check

If anything fails (lint, build, tests), fix it before committing.
