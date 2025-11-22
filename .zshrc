#!/bin/zsh

autoload -U compinit && compinit
autoload -U select-word-style
select-word-style bash

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY

mkdir -p $HOME/.zsh

install_plugin() {
    local plugin_name=$1
    local repo_url=$2
    local plugin_path="$HOME/.zsh/$plugin_name"

    if [[ ! -d "$plugin_path" ]]; then
        echo "Installing $plugin_name..."
        git clone "$repo_url" "$plugin_path"
    fi
}

install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
install_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
install_plugin "zsh-fzf-history-search" "https://github.com/joshskidmore/zsh-fzf-history-search.git"
install_plugin "pure" "https://github.com/sindresorhus/pure.git"

source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$HOME/.zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# [alt/ctrl] + [left/right] to move between words
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export PATH=$HOME/.local/bin:$PATH

function is_bin_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
}

is_bin_in_path nvim && alias vim=nvim
source ~/.env


if [[ $(uname) == "Darwin" ]]; then
  alias pack="~/nix/pack"
  export PATH="/opt/homebrew/bin:$PATH"
  export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig"
fi

