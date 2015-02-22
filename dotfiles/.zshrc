# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/overfl0w/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors
eval $(dircolors ~/.dircolors)

# Aliases
alias ls='ls --color=auto'
alias vim='echo You mean nvim && sleep 5 && nvim'

alias zshrc='nvim ~/.zshrc'
alias reloadzsh='. ~/.zshrc'

# For termite's Ctrl-Shift-T
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Prompt
PS1='╭─%B%F{red}[%T] %f%bI am %F{yellow}%n %f%bin %F{yellow}%~ %f%b
╰─➤ '
