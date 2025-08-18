autoload -U compinit && compinit

autoload -U select-word-style
select-word-style bash

HISTFILE=$HOME/.zsh_history        # 1 file, no rotation
HISTSIZE=1000000000                # in-memory events (use -1 for true “no limit”)
SAVEHIST=$HISTSIZE                 # same on disk

setopt EXTENDED_HISTORY            # “: epoch:duration;” header per entry
setopt INC_APPEND_HISTORY          # write each command instantly
setopt APPEND_HISTORY              # never clobber the file

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

export PURE_PROMPT_SYMBOL='λ'

alias ls='ls --color=auto'
zstyle ':completion:*' menu select

os_name=$(uname -s)

# [alt/ctrl] + [left/right] to move between words
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

alias yay='paru'

export PATH=$HOME/.local/bin:$PATH
# export NODE_PATH=$(npm root --quiet -g)

function is_bin_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
}

is_bin_in_path nvim && alias vim=nvim
source ~/.env

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/sagar/.lmstudio/bin"
alias pack="~/nix/pack"

export PATH="/Applications/Racket v8.16/bin:$PATH"
alias ssh="TERM=xterm-256color ssh"

export PATH="/opt/homebrew/bin:$PATH"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig"

