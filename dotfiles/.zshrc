source ~/.zplug/zplug
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/taskwarrior", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/lein", from:oh-my-zsh
zplug "plugins/git-flow-avh", from:oh-my-zsh
zplug "djui/alias-tips"
zplug "b4b4r07/zplug"
zplug "k4rthik/git-cal", as:command
zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf, of:"*linux*amd64*"

if ! zplug check --verbose; then
  echo; zplug install
fi

zplug load

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
setopt correct
bindkey -e
# The following lines were added by compinstall
zstyle :compinstall filename '/home/overfl0w/.zshrc'

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

# Fish search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases
alias ls='ls --color=auto'
alias vim='echo You mean nvim && sleep 5 && nvim'

alias tsy='task sync'
alias in='task add +in'
alias inbox='task +in +PENDING'
alias done_today='task +COMPLETED end:today all'
alias p.files='git -C ~/.files/ add . && git -C ~/.files/ commit && git -C ~/.files/ push'

alias zshrc='nvim ~/.zshrc'
alias reloadzsh='. ~/.zshrc'

# For termite's Ctrl-Shift-T
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

BASE16_THEME="eighties.dark"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_THEME.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

setopt promptsubst

# local sep='' #  █
local sep=''
function sep-wrap {
  local open="%F{$1}%K{$3}${sep}%K{$1}%F{$2}"
  local close="%f%k"

  echo "$open$4$close"
}

local inbox=$(sep-wrap blue white black 'Inbox: $(inbox count)')
local task_changes=$(sep-wrap 011 black blue 'Changes: $(cat ~/.config/task/backlog.data | tail -n +2 | wc -l)')
local dotfiles=$(sep-wrap red black 011 '.files: $(git -C ~/.files/ status --porcelain | wc -l)')
local timep='%F{016}%T%f%b'
local username='%F{010}%n%f'
local currdir='%F{011}%25<…<%~%<<%f'


PATH=$PATH:~/.cargo/bin

# Prompt
PROMPT="╭─[${timep}] ${username} ${currdir}
╰─➤ "

RPROMPT="%F{white}${inbox}${task_changes}${dotfiles}"

wd() {
  . /home/overfl0w/bin/wd/wd.sh
}
