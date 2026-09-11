---
name: ofx-commit
description: Use when the user asks to commit the current changes.
disable-model-invocation: true
---

# Commit

## Create commit

1. Run `git status --short --untracked-files=all` and `git diff HEAD` to understand every modified, deleted, and untracked change. The diff omits untracked file contents, so read each untracked path from the status output directly.
2. Classify every path in the status output as either in scope or out of scope for the current context. Finish the classification before staging anything, so no path is left unaccounted for.
3. Stage only the in-scope paths and hunks with path-scoped `git add` commands, using `git add --patch` when a file also contains out-of-scope changes. Treat changes created by other agents as out of scope unless they belong to the current context. Never use `git add -A`, `git add .`, or an equivalent repository-wide pathspec.
4. Create one commit containing only the in-scope changes, with a message in the format below. Exclude out-of-scope changes even when they are already staged, and preserve them in the working tree and index.

## Commit message

Write every commit message to this template:

```
<type>: <description>

[body]
```

- A message has one required type-and-description line and an optional body.
- The body, one blank line after the description, carries why the change was made: the problem it solves, the constraint that forced this approach over an obvious alternative, or the consequence a reader would not predict from the diff. Omit it when the description says enough.

### Types

Use one of the following types:

- `build`: Changes that affect the build system or external dependencies.
- `chore`: Repository maintenance outside the other types, including `.gitignore`, `.gitattributes`, `.editorconfig`, `CODEOWNERS`, issue templates, merge-request templates, IDE, devcontainer, or local developer-tool configuration, and maintenance scripts unrelated to building, testing, or CI.
- `ci`: Changes to CI configuration files and scripts.
- `docs`: Documentation only changes.
- `feat`: A new feature.
- `fix`: A bug fix.
- `perf`: A code change that improves performance.
- `refactor`: A code change that neither fixes a bug nor adds a feature.
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- `test`: Adding missing tests or correcting existing tests.
