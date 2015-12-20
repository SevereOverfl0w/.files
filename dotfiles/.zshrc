source ~/.zplug/zplug
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/taskwarrior", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/archlinux", from:oh-my-zsh
zplug "djui/alias-tips"
zplug "b4b4r07/zplug"
zplug "mfaerevaag/wd"
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
alias inbox='task +in +PENDING'
# alias npm="npm --python=$(type python2 | awk '{print $3}')"

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
local inbox='%F{blue}[Inbox: $(inbox count)]%f'
local dotfiles='%F{red}[Dotfiles: $(git -C ~/.files/ status --porcelain | wc -l)]%f'
local timep='%F{016}%T%f%b'
local username='%F{010}%n%f'
local currdir='%F{011}%25<…<%~%<<%f'

# Prompt
PROMPT="╭─[${timep}] ${username} ${currdir} 
╰─➤ "

RPROMPT="${inbox} ${dotfiles}"

wd() {
  . /home/overfl0w/bin/wd/wd.sh
}
