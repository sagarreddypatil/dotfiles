export ZSH="/home/sagar/.oh-my-zsh"

ZSH_THEME=""

DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions poetry zsh-fzf-history-search fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

function precmd {
  print -Pn "\e[ q"
}

__git_files () {
    # fix for slow yadm completion
    _wanted files expl 'local files' _files
}

export PATH="$HOME/.local/bin/:$PATH"

open() {
	nohup xdg-open $1 </dev/null >/dev/null 2>&1 &; disown
}

alias fixwifi="sudo systemctl restart NetworkManager"
alias fixmouse="sudo modprobe -r psmouse && sudo modprobe psmouse && sleep 1 && ~/.config/i3/libinput.py"
alias resetmouse="~/.config/i3/libinput.py"

activate() {
  # find a venv subdirectory and activate it
  venv=$(find . -mindepth 2 -maxdepth 2 -type d -name 'bin' -exec test -e "{}/activate" \; -print -quit)
  if [ -z "$venv" ]; then
    echo "No virtualenv found"
  else
    source "$venv/activate"
  fi
}
alias sl="sl -e"

eval "$(zoxide init zsh)"

_zoxide_zsh_tab_completion() {
    (( $+compstate )) && compstate[insert]=menu
    local keyword="${words:2}"
    local completions=(${(@f)"$(zoxide query -l "$keyword")"})


    if [[ ${#completions[@]} == 0 ]]; then
        _files -/
    else
        compadd -U -V z "${(@)completions}"
    fi
}

if [ "${+functions[compdef]}" -ne 0 ]; then
    compdef _zoxide_zsh_tab_completion z 2> /dev/null
fi

alias gl="git log --decorate --oneline --graph --all"

function swap()         
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

