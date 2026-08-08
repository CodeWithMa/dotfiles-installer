#!/usr/bin/env zsh

set -euo pipefail

typeset -A REPOS=(
    [mpv]="$HOME/.config/mpv"
    [waybar]="$HOME/.config/waybar"
    [xkb]="$HOME/.config/xkb"
    [nvim]="$HOME/.config/nvim"
    [pipewire]="$HOME/.config/pipewire"
    [ranger]="$HOME/.config/ranger"
    [rofi]="$HOME/.config/rofi"
    [git]="$HOME/.config/git"
    [hypr]="$HOME/.config/hypr"
    [alacritty]="$HOME/.config/alacritty"
    [zsh-base]="$HOME/.config/zsh"
)

OLD_PATTERNS=(
    "https://codeberg.org/CodeWithMa/dotfiles-"
)

update_remote() {
    local dir="$1"
    local name="$2"
    local current_url
    current_url=$(git -C "$dir" remote get-url origin 2>/dev/null) || return 0

    for pattern in "${OLD_PATTERNS[@]}"; do
        if [[ "$current_url" == *"$pattern"* ]]; then
            local new_url="https://github.com/CodeWithMa/${name}.git"
            echo "[$dir] Updating remote:"
            echo "  Old: $current_url"
            git -C "$dir" remote set-url origin "$new_url"
            echo "  New: $(git -C "$dir" remote get-url origin)"
            return 0
        fi
    done

    echo "[$dir] Already up to date: $current_url"
}

for repo target in ${(kv)REPOS}; do
    if [[ -d "$target/.git" ]]; then
        update_remote "$target" "dotfiles-$repo"
    fi
done

echo "Done."
