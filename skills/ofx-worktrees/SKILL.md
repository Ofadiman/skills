---
name: ofx-worktrees
description: Use when the user asks to create, switch to, list, or remove a git worktree, or to check a pull or merge request out into one.
---

# Worktrees

Every worktree and its branch is created, switched to, listed, and removed through the `wt` CLI (worktrunk), and only when I ask for one. Resolve any flag this file leaves out from `wt <command> --help`.

## Naming

A worktree is addressed by its branch name, so the name you pick is a branch name — lowercase and hyphen-separated:

- **A ticket covers the work** — the ticket key followed by a slug of its title: Jira `JIRA-123` titled "Search bar drops the last keystroke" gives `jira-123-search-bar-drops-last-keystroke`. Read the title from the ticket rather than from my paraphrase of it.
- **No ticket** — a slug of the change itself, taken out of the context I gave you: `fix-config-parser-race`, `add-retry-to-upload`.
- **A pull or merge request already exists** — pass its URL and let `wt` reuse the remote branch name.

## Creating and switching

```sh
wt switch --create <name> --no-cd --format=json --yes
```

`--no-cd` and `--yes` are what make the command usable from a tool call: the working directory never follows a switch, and an approval prompt would block a non-interactive shell. Take the worktree path out of the JSON result and treat it as the root of the work, addressing every following file and command with an absolute path under it.

- `--base <ref>` bases the branch on something other than the repository's default branch: `--base origin/release`.
- Switching to a branch that already exists is the same command with `--create` dropped. `wt list --branches --format=json` shows which branches and worktrees are already there.
- A pull or merge request URL replaces `<name>`, also with `--create` dropped:

  ```sh
  wt switch https://github.com/owner/repo/pull/123 --no-cd --format=json --yes
  wt switch https://gitlab.com/owner/repo/-/merge_requests/101 --no-cd --format=json --yes
  ```

  `pr:123` and `mr:101` are the short forms.

- A repository can configure a pre-start hook that provisions the new worktree by installing dependencies and building it, which runs for minutes, so allow this command a matching timeout. `wt config show` names the hooks a repository carries.

## Listing

`wt list --format=json` reports every worktree with its path, its uncommitted changes, and its divergence from the default branch and its upstream.

## Removing

```sh
wt remove <name> --format=json --yes --foreground
```

This removes the worktree and deletes its branch once the branch adds nothing to the default branch. `--foreground` holds the command until the removal finishes, so the next command sees the result.

- `--force` also removes a worktree carrying uncommitted changes.
- `--force-delete` also deletes a branch whose commits are unmerged.

Either flag discards work, so show me the blast radius and wait for my go-ahead: the uncommitted and untracked files for `--force`, the commits the branch adds for `--force-delete`.
