---
name: ofx-commit
description: Use when the user asks to commit the current changes.
---

# Commit

## Create commit

1. Run `git status --short --untracked-files=all` and `git diff HEAD` to see every change, and read each untracked file the status lists, since the diff leaves their contents out.
2. Classify every path in the status output as in scope or out of scope for the current context, splitting a file by hunk when it mixes both. Changes another agent made are out of scope unless they belong to the current context. The step is done when every change sits on one side.
3. Stage each in-scope path by name with `git add`, and stage only the in-scope hunks of a mixed file with `git apply --cached` on a patch holding just those hunks.
4. Create one commit holding exactly the in-scope changes, with a message in the format below. Every out-of-scope change is left as it was, staged or unstaged.
5. When the commit succeeds, your whole reply is the first line of the commit message, verbatim. When it fails, report the failure.

## Commit message

```
<type>: <description>

[body]
```

The body carries why the change was made: the problem it solves, the constraint that forced this approach over an obvious alternative, or the consequence a reader would not predict from the diff. Omit it when the description says enough.

`<type>` is one of:

- `build`: Changes that affect the build system or external dependencies.
- `chore`: Repository maintenance outside the other types, including `.gitignore`, `.gitattributes`, `.editorconfig`, `CODEOWNERS`, issue templates, merge-request templates, IDE, devcontainer, or local developer-tool configuration, and maintenance scripts unrelated to building, testing, or CI.
- `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `style`, `test`: In their conventional-commit sense.
