autoload -U compinit && compinit

autoload -U select-word-style
select-word-style bash

HISTFILE=$HOME/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

function precmd {
  if [[ $TERM == foot ]]; then
    print -Pn "\e[ q"
  fi
}

alias ls='ls --color=auto'
zstyle ':completion:*' menu select

open() {
	nohup xdg-open $1 </dev/null >/dev/null 2>&1 &; disown
}

# [alt/ctrl] + [left/right] to move between words
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

alias yay='paru'
