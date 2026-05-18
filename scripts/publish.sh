#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
main_worktree="${MAIN_WORKTREE:-$repo_root/.worktrees/main}"

if [ ! -d "$main_worktree/.git" ] && ! git -C "$main_worktree" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "main worktree not found at: $main_worktree" >&2
  echo "Create it with: git worktree add \"$main_worktree\" main" >&2
  exit 1
fi

build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT

hugo --minify --destination "$build_dir"
find "$main_worktree" -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
rsync -a "$build_dir/" "$main_worktree/"

cd "$main_worktree"
git add -A

if git diff --cached --quiet; then
  echo "No changes to publish."
  exit 0
fi

git commit -m "chore: publish site"
git push origin main

echo "Published main from $repo_root"
