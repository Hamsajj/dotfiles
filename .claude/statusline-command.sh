#!/usr/bin/env bash
# Claude Code statusLine command
# Mirrors key elements from Powerlevel10k p10k config:
#   dir | vcs (git branch + dirty) | model | context usage

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
short_dir="${cwd/#$HOME/\~}"

# Git info (branch + dirty indicator)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then
      dirty="*"
    fi
    git_info=" \033[33m${branch}${dirty}\033[0m"
  fi
fi

# Context window usage
ctx_info=""
if [ -n "$used_pct" ]; then
  ctx_int=$(printf "%.0f" "$used_pct")
  ctx_info=" ctx:${ctx_int}%"
fi

printf "\033[34m%s\033[0m%s \033[90m%s%s\033[0m" \
  "$short_dir" \
  "$git_info" \
  "$model" \
  "$ctx_info"
