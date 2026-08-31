---
name: ofx-update-branch
description: Use when the current branch has fallen behind the branch it was cut from, or the user asks to update, sync, or rebase it onto its base, or a merge conflict with that base needs resolving.
---

# Update branch

Bring the current branch up to date with the branch it was cut from — the repository's default branch, or another feature branch this one is stacked on.

## Workflow

### 1. Resolve the base

`<remote>` is the remote behind the current branch's upstream, or `origin` when the branch has no upstream.

Take the first base that resolves:

1. The base I named when invoking this skill.
2. The target branch of the open merge or pull request for this branch (`glab mr view` on GitLab, `gh pr view --json baseRefName` on GitHub).
3. The remote default branch: `git symbolic-ref --short refs/remotes/<remote>/HEAD` without its `<remote>/` prefix, refreshing the ref with `git remote set-head <remote> --auto` when it is missing.

Then confirm the working tree is clean with `git status --porcelain`. Stop and report when the working tree carries changes, HEAD is detached, the current branch is the base, or no rule yields a base.

### 2. Merge

Record the pre-merge commit with `git rev-parse HEAD`, so later steps can compare against the branch as it stood before the merge.

Fetch the base with `git fetch <remote> <base>`, then merge it with `git merge --no-edit <remote>/<base>`. When the fetch reports the base does not exist on the remote and `<base>` exists locally, merge `<base>` instead and report the base as local-only. Stop and report any other fetch failure. `<base-ref>` below is whichever ref you merged.

When the merge reports the branch is already up to date, say so and stop.

### 3. Resolve the conflicts

Enter this step only while the merge is stopped on a conflict.

1. **See the current state.** Read the merge status (`git status`) and every conflicting file, including its conflict markers where it has them. A conflict over a binary file, a rename, a submodule, or a file one side deleted carries no markers and is read from the status output instead.
2. **Recover both intents.** For each conflicting file, read the commits behind both sides (`git log --merge -p -- <path>`) and state in one line per side what that side was trying to do. Where a commit names a merge request, pull request, or ticket, read it. Every conflicting file has both intents named before you resolve anything.
3. **Resolve each conflict.** Preserve both intents where they compose. Where they clash, keep the side that serves this branch's goal — read that goal off the branch's ticket key or its own commits (`git log <base-ref>..HEAD`) — and state the trade-off you made. Reproduce the existing behaviour of both sides; add no new behaviour of your own.
4. **Complete the merge.** Run `git add` on the resolved paths, then `git commit --no-edit`. Every conflict is resolved and the merge carried through to a commit.

When a conflict stays ambiguous after sub-step 2 and you cannot tell which behaviour to keep, stop and report the file, both intents, and the decision you need from me. Leave the merge in progress with its conflict state intact rather than aborting it.

### 4. Verify

Run this step once, on the resulting HEAD, whether or not a conflict came up.

Discover the project's checks from the repo — its task runner, package scripts, or CI config — and run every one that runs locally and covers a path the merge touched (`git diff --name-only <pre-merge commit> HEAD`). Repair what the merge turned red and commit each repair on top; when a failure's origin is unclear, run that check against the pre-merge commit before touching it, and report a failure that was already red rather than fixing it here.

Green is the gate for step 5: report a check you cannot get to green and leave the branch unpushed.

### 5. Publish and report

Push the branch with `git push`, or `git push --set-upstream <remote> HEAD` when it has no upstream yet.

Report the base and the rule that resolved it, the checks you ran, every conflict trade-off, every repair you committed, and the pushed ref. Say `none` where a line has nothing to report.
