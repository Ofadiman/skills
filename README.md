# Skills

My custom agent skills.

## Install

Every skill, into Claude Code and Codex:

```sh
skills add Ofadiman/skills --global --yes --agent claude-code codex --skill '*'
```

## Skills

- [`ofx-commit`](skills/ofx-commit/SKILL.md) — use when committing the current changes. Classifies every path as in or out of scope, stages only the in-scope ones, and writes a conventional-commit message whose body carries why the change was made.
  `skills add Ofadiman/skills --global --yes --agent claude-code codex --skill ofx-commit`
- [`ofx-sdd`](skills/ofx-sdd/SKILL.md) — use when starting a feature, or resuming one already under way. Interviews you into a Q&A file you answer in your editor, turns the settled answers into a skeleton plan, then implements it once you agree to the plan.
  `skills add Ofadiman/skills --global --yes --agent claude-code codex --skill ofx-sdd`
- [`ofx-update-branch`](skills/ofx-update-branch/SKILL.md) — use when the current branch has fallen behind the branch it was cut from, or a conflict with that base needs resolving. Resolves the base, merges, settles each conflict by recovering both sides' intent, verifies against the repo's own checks, then pushes.
  `skills add Ofadiman/skills --global --yes --agent claude-code codex --skill ofx-update-branch`
- [`ofx-worktrees`](skills/ofx-worktrees/SKILL.md) — use when asking for a git worktree to be created, switched to, listed, or removed. Routes every worktree action through the `wt` CLI, names branches off the ticket key or the change itself, and gates the destructive removal flags behind your go-ahead.
  `skills add Ofadiman/skills --global --yes --agent claude-code codex --skill ofx-worktrees`
