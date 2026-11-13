---
name: ofx-update-branch
description: Use when the current branch has fallen behind the branch it was cut from.
disable-model-invocation: true
---

# Update branch

## 1. Resolve the base

`<remote>` is the remote behind the current branch's upstream, or `origin` when the branch has no upstream.

Take the first base that resolves:

1. The base I named when invoking this skill.
2. The target branch of the open merge or pull request for this branch (`glab mr view` on GitLab, `gh pr view --json baseRefName` on GitHub).
3. The remote default branch: `git symbolic-ref --short refs/remotes/<remote>/HEAD` without its `<remote>/` prefix, refreshing the ref with `git remote set-head <remote> --auto` when it is missing.

Stop and report when `git status --porcelain` shows changes, HEAD is detached, the current branch is the base, or no rule yields a base.

## 2. Merge

Record the pre-merge commit with `git rev-parse HEAD`.

Fetch the base with `git fetch <remote> <base>`, then merge it with `git merge --no-edit <remote>/<base>`. When the fetch reports the base does not exist on the remote and `<base>` exists locally, merge `<base>` instead and report the base as local-only. Stop and report any other fetch failure.

When the merge reports the branch is already up to date, say so and stop. When it stops on a conflict, go to step 3; when it completes, go to step 4.

## 3. Resolve the conflicts

1. **See the current state.** Read `git status` and every conflicting file. A conflict over a binary file, a rename, a submodule, or a file one side deleted carries no markers; read it from the status output.
2. **Recover both intents.** For each conflicting file, read the commits behind both sides (`git log --merge -p -- <path>`) and state in one line per side what that side was trying to do. Where a commit names a merge request, pull request, or ticket, read it.
3. **Resolve each conflict.** Preserve both intents where they compose. Where they clash, keep the side that serves this branch's goal and state the trade-off you made; read the goal off the branch's ticket key or its own commits (`git log MERGE_HEAD..HEAD`). Build every resolution only from behaviour the two sides already have.
4. **Complete the merge.** Stage every resolved path, then run `git commit --no-edit`.

When you cannot tell which side's behaviour to keep, stop and report the file, both intents, and the decision you need from me, leaving the merge in progress and that file unresolved.

## 4. Verify

Discover the project's checks from the repo (its task runner, package scripts, or CI config) and run every one that runs locally and covers a path the merge touched (`git diff --name-only <pre-merge commit> HEAD`). Repair what the merge turned red, committing each repair on top. When a failure's origin is unclear, run that check on the pre-merge commit before touching it; a failure already red there goes into the report unrepaired.

Every check the merge turned red is green before step 5; report one you cannot repair and leave the branch unpushed.

## 5. Publish and report

Push the branch to `<remote>`, setting its upstream when it has none.

Report the base and the rule that resolved it, the checks you ran, every conflict trade-off, every repair you committed, every failure that was already red, and the pushed ref. Say `none` where a line has nothing to report.
