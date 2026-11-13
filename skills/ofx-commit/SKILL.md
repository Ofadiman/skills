---
name: ofx-commit
description: Use when the user asks to commit the current changes.
---

# Commit

## Create commit

1. Run `git status --short --untracked-files=all` and `git diff HEAD` to see every change, and read each untracked file the status lists.
2. Classify every path in the status output as in scope or out of scope for the current context, splitting a file by hunk when it mixes both. Another agent's changes are out of scope unless they belong to the current context.
3. Stage each in-scope path by name with `git add`, and the in-scope hunks of a mixed file with `git apply --cached`.
4. Create one commit holding exactly the in-scope changes, with a message in the format below. Every out-of-scope change is left as it was, staged or unstaged.
5. When the commit succeeds, your whole reply is the first line of the commit message, verbatim. When it fails, report the failure.

## Commit message

```
<type>: <description>

[body]
```

The body carries why the change was made: the problem it solves, the constraint that forced this approach over an obvious alternative, or the consequence a reader would not predict from the diff. Omit it when the description says enough.

`<type>` is one of `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `style`, or `test`.
