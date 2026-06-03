#!/bin/sh
# Claude Code statusLine command — mirrors Oh My Zsh robbyrussell theme
# Input: JSON via stdin

input=$(cat)

# Current directory basename
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir=$(basename "$cwd")

# Git branch and dirty state from workspace
branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
dirty=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)

# ANSI colors (will be dimmed by terminal)
reset="\033[0m"
bold_green="\033[1;32m"
cyan="\033[0;36m"
bold_blue="\033[1;34m"
red="\033[0;31m"
yellow="\033[0;33m"

if [ -n "$branch" ]; then
  if [ -n "$dirty" ]; then
    git_part=$(printf " ${bold_blue}git:(${red}%s${bold_blue})${reset} ${yellow}✗${reset}" "$branch")
  else
    git_part=$(printf " ${bold_blue}git:(${red}%s${bold_blue})${reset}" "$branch")
  fi
else
  git_part=""
fi

printf "${bold_green}➜${reset}  ${cyan}%s${reset}%s\n" "$dir" "$git_part"
