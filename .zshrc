autoload -U compinit && compinit

autoload -U select-word-style
select-word-style bash

HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000

setopt extended_history       # record timestamp of command in HISTFILE
setopt SHARE_HISTORY

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

export PURE_PROMPT_SYMBOL='λ'

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

export PATH=$HOME/.local/bin:$PATH
export RUSTC_WRAPPER=/usr/bin/sccache
export NODE_PATH=$(npm root --quiet -g)
alias vim=nvim
