Review the codebase for technical debt. Look for:

1. Duplicated code that could be extracted into shared functions
2. TODO, FIXME, HACK, or XXX comments that should be addressed
3. Unused imports, dead code, or orphaned files
4. Inconsistent naming or patterns
5. Missing error handling
6. Overly complex functions that could be simplified
7. Dependencies that are imported but not used

List what you find with file locations and a brief description of each issue.

Fix anything that's safe to fix without changing behaviour. For anything that requires a decision or might change behaviour, just list it — don't fix it.

If you fix anything, run the build/lint commands to confirm nothing is broken.
