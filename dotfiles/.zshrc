if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export ZPLUG_ROOT=${XDG_DATA_HOME:-$HOME/.local/share}/zplug
export ZPLUG_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/zplug
source ${ZPLUG_ROOT}/init.zsh

zplug mafredri/zsh-async
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug changyuheng/zsh-interactive-cd, use:zsh-interactive-cd.plugin.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug romkatv/powerlevel10k, use:powerlevel10k.zsh-theme, as:theme

zplug load

source ~/.config/p10k-pure.zsh

## Arrow Keys ###########################################
zmodload zsh/terminfo
# OPTION 1: for most systems
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# OPTION 2: for iTerm2 running on Apple MacBook laptops
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

alias zshrc='$EDITOR ~/.zshrc'
alias reloadzsh='. ~/.zshrc'

alias v="nvim"

# package stuff
alias pacupg='sudo xbps-install -Su'
alias pacins='sudo xbps-install -S'
alias pacrem='sudo xbps-remove -R'
alias pacfind='xbps-query -R -s'
alias pacinfo='xbps-query -R'
alias paclocate='xbps-query -Ro'
alias paclist='xbps-query -Rf'

pacbin(){
  xlocate 'bin\/'$1'$'
}

# For termite's Ctrl-Shift-T
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

PATH=$PATH:$HOME/bin:$HOME/.files/bin/:$HOME/.local/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.cargo/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/doc/fzf/key-bindings.zsh ] && source /usr/share/doc/fzf/key-bindings.zsh; source /usr/share/doc/fzf/completion.zsh

function fzf-ghq() {
    local selected_dir=$(ghq list -p | $(__fzfcmd) --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N fzf-ghq
bindkey '^g^h' fzf-ghq

export PIPX_BIN_DIR="$HOME/bin"

function t() {
  local custom_command="t-$1"
  if [ 1 -eq ${+commands[$custom_command]} ]; then
    shift;
    "$custom_command" "$@"
  else
    topydo "$@"
  fi
}

alias v='nvim'

_fzf_complete_gopass() {
  _fzf_complete '+m' "$@" < <(
    gopass find ''
  )
}

_fzf_complete_gopass_post() {
  read passurl
  echo ${(q)passurl}
}

command -v gopass >/dev/null 2>&1 && source <((gopass completion zsh | head -n -1 | tail -n +2; echo 'compdef _gopass gopass'))

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line
