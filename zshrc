#!/usr/bin/env zsh
# zsh respect XDG_CONFIG_HOME

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"

export XDG_CACHE_HOME="$HOME/.cache"
#export XDG_RUNTIME_DIR="$HOME/$TMPDIR"

source "$XDG_CONFIG_HOME/zsh/zshrc"
