#!/usr/bin/env zsh

GIT_CLONE_SOURCE_DOMAIN=codeberg.org
GIT_CLONE_SOURCE_USERNAME=CodeWithMa

typeset -A REPOS=(
  [mpv]="$HOME/.config/mpv"
  [waybar]="$HOME/.config/waybar"
  [xkb]="$HOME/.config/xkb"
  [nvim]="$HOME/.config/nvim"
  [ranger]="$HOME/.config/ranger"
  [rofi]="$HOME/.config/rofi"
  [git]="$HOME/.config/git"
  [hypr]="$HOME/.config/hypr"
  [alacritty]="$HOME/.config/alacritty"
  [zsh-base]="$HOME/.config/zsh"
)

for repo target in ${(kv)REPOS}; do
  if [[ ! -d "$target" ]]; then
    git clone "https://$GIT_CLONE_SOURCE_DOMAIN/$GIT_CLONE_SOURCE_USERNAME/dotfiles-$repo.git" "$target"
  else
    echo "Skipping $repo (already exists at $target)"
  fi
done

# zsh-base has submodules and needs .zshrc symlinked
if [[ -d "$HOME/.config/zsh" ]]; then
  git -C "$HOME/.config/zsh" submodule update --init --recursive
  ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
fi
