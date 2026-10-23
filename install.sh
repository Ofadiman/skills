#!/usr/bin/env bash

set -euo pipefail

repo_root=$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

for skills_dir in "$HOME/.claude/skills" "$HOME/.codex/skills"; do
  mkdir -p "$skills_dir"

  for source_dir in "$repo_root"/skills/*/; do
    source_dir="${source_dir%/}"
    link="$skills_dir/$(basename "$source_dir")"

    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "error: $link already exists and is not a symlink, remove it manually first" >&2
      exit 1
    fi

    ln -s -f -n "$source_dir" "$link"
    echo "linked $link -> $source_dir"
  done
done
