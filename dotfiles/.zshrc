if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

source ~/.config/zplug/zplug

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

zplug petervanderdoes/gitflow-avh, do: "make install prefix=$HOME"
zplug petervanderdoes/git-flow-completion
zplug mafredri/zsh-async
zplug sindresorhus/pure
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions

zplug load

## Arrow Keys ###########################################
# OPTION 1: for most systems
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# OPTION 2: for iTerm2 running on Apple MacBook laptops
zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
# OPTION 3: for Ubuntu 12.04, Fedora 21, and MacOSX 10.9
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
## EMACS mode ###########################################
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
## VI mode ##############################################
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors
eval $(dircolors ~/.dircolors)

# Home / Backspace / End keys #
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal

export EDITOR='nvim'
# Aliases
alias ls='ls --color=auto'
alias vim='echo You mean nvim && sleep 5 && nvim'

alias bc_task='export TASKRC=/home/dominic/.juxt_taskrc'
alias reset_task='unset TASKRC'

alias t='task'
alias tsy='task sync'
alias in='task add +in'
alias inbox='task in'
alias win='in pro:juxt'
alias done_today='task end:today all'
alias p.files='git -C ~/.files/ add . && git -C ~/.files/ commit && git -C ~/.files/ push'

alias zshrc='$EDITOR ~/.zshrc'
alias reloadzsh='. ~/.zshrc'
alias j="$EDITOR ~/sync/general/journal/\`date +%Y-%m-%d\`.ad"

# For termite's Ctrl-Shift-T
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# BASE16_THEME="eighties.dark"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_THEME.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

setopt promptsubst

# local sep='' #  █
local sep=''
function sep-wrap {
  local open="%F{$1}%K{$3}${sep}%K{$1}%F{$2}"
  local close="%f%k"

  echo "$open$4$close"
}

local inbox=$(sep-wrap blue white black 'Inbox: $(t +in status:pending count)')
# local task_changes=$(sep-wrap 011 black blue 'Changes: $(cat ~/.config/task/backlog.data | tail -n +2 | wc -l)')
local dotfiles=$(sep-wrap red black 011 '.files: $(git -C ~/.files/ status --porcelain | wc -l)')
local timep='%F{016}%T%f%b'
local username='%F{010}%n%f'
local currdir='%F{011}%25<…<%~%<<%f'


# Prompt
# PROMPT="╭─[${timep}] ${username} ${currdir}
# ╰─➤ "

# RPROMPT="%F{white}${inbox}${task_changes}${dotfiles}"

PATH=$PATH:$HOME/bin:$HOME/.files/bin/:$HOME/.gem/ruby/2.3.0/bin
LEDGERF=/home/dominic/sync/general/ledger/2016.ledger
alias ledger='ledger -f $LEDGERF'

autoload -U promptinit && promptinit
PURE_CMD_MAX_EXEC_TIME=10
# prompt pure
