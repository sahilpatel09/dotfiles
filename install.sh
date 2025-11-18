#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

link_file() {
    local src=$1
    local dest=$2
    ln -sf "$src" "$dest"
    echo "Linked $dest -> $src"
}

# load rcs
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -f ~/dotfiles/macrc ]]; then
        link_file "$DOTFILES/macrc" "$HOME/.macrc"
        echo "Linked MacRC"
    fi
elif [[ "$(uname)" == "Linux" ]]; then
    if [[ -f ~/dotfiles/linuxrc ]]; then
        link_file "$DOTFILES/linuxrc" "$HOME/.linuxrc"
        echo "Linked LinuxRC"
    fi
fi

# Bash
link_file "$DOTFILES/bashrc" "$HOME/.bashrc"
link_file "$DOTFILES/bash_profile"  "$HOME/.bash_profile"
link_file "$DOTFILES/alias.bash"  "$HOME/alias.bash"
link_file "$DOTFILES/bash_profile" "$HOME/.bash_profile"

# Git
link_file "$DOTFILES/gitconfig" "$HOME/.gitconfig"

# Vim
#link_file "$DOTFILES/vimrc" "$HOME/.vimrc"

# Tmux
#link_file "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"

