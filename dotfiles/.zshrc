HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
declare -A ZINIT
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

autoload -Uz compinit
compinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light mafredri/zsh-async
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit ice pick"zsh-interactive-cd.plugin.zsh";
zinit light changyuheng/zsh-interactive-cd
zinit ice depth=1; zinit light romkatv/powerlevel10k

zstyle ':completion::complete:git-switch:*:branch-names' menu yes select=long search

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
alias reloadzsh='exec zsh'

alias v="nvim"

# package stuff
alias pacupg='sudo xbps-install -Su'
alias pacins='sudo xbps-install -S'
alias pacrem='sudo xbps-remove -R'

# alias pacfind='xbps-query -R -s'
function pacfind(){
    xbps-query --regex -R -s "$@" | grep -Pv -- "-dbg-\d"
}

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
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

function fzf-ghq() {
    local selected_dir=$(ghq list -p | $(__fzfcmd) --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N fzf-ghq
bindkey '^g^h' fzf-ghq

relpath() {
    [[ $# -ge 1 ]] && [[ $# -le 2 ]] || return 1
    local target=${${2:-$1}:a} # replace `:a` by `:A` to resolve symlinks
    local current=${${${2:+$1}:-$PWD}:a} # replace `:a` by `:A` to resolve symlinks
    local appendix=${target#/}
    local relative=''
    while appendix=${target#$current/}
        [[ $current != '/' ]] && [[ $appendix = $target ]]; do
        if [[ $current = $appendix ]]; then
            relative=${relative:-.}
            print ${relative#/}
            return 0
        fi
        current=${current%/*}
        relative="$relative${relative:+/}.."
    done
    relative+=${relative:+${appendix:+/}}${appendix#/}
    print $relative
}

function fzf-worktree() {
    worktrees=()
    typeset -A worktrees

    local worktree=()
    typeset -A worktree

    while IFS= read -r line; do
      if [[ $line == worktree\ * ]]; then
        worktree["dir"]="${line#worktree }";
      elif [[ $line == "branch "* ]]; then
        worktree[branch]="${line#branch }"
      elif [[ $line == "HEAD "* ]]; then
        worktree["HEAD"]="${line#HEAD }"
      elif [[ -z $line ]]; then
        if [[ -v worktree[branch] ]]; then
          local branch="$(git rev-parse --abbrev-ref "${worktree[branch]}")"
          worktrees[$branch]="${worktree["dir"]}"
        else
          local dir="${worktree["dir"]}"
          local sha="$(git -C "$dir" rev-parse --short HEAD)"
          worktrees[$sha]="$dir"
        fi
        worktree=()
      fi

    done < <(git worktree list --porcelain)

    IFS=$'\n' local fzfresult=("${(@f)$(print -l "${(@k)worktrees}" | $(__fzfcmd) --query "$LBUFFER" --expect 'ctrl-d,alt-d' --preview-window=down,8 --preview "git worktree list | grep -F '[{}]'; printf '\n'; git -c color.ui=always lg '{}'")}")

    local selected_branch="$fzfresult[2]"
    local binding="$fzfresult[1]"

    if [ -n "$selected_branch" ]; then
      local selected_dir="${worktrees[$selected_branch]}"
      local rm_args
      case $binding in
        '')
          BUFFER="cd ${selected_dir}"
          zle accept-line
          ;;
        'alt-d')
          rm_args="-f "
          ;&
        'ctrl-d')
          BUFFER="git worktree remove $rm_args"
          CURSOR="${#BUFFER}"
          # Space to allow for entering -f
          BUFFER+=" ${(q)selected_dir}"
          ;;
      esac
    fi
}

zle -N fzf-worktree
bindkey '^g^w' fzf-worktree

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

function _quick_todo(){
  zle push-line
  BUFFER="~/doc/bin/single-todo-entry"
  zle accept-line
  zle reset-prompt
}

zle -N _quick_todo
bindkey '^i^t' _quick_todo

alias v='nvim'

# https://github.com/android-password-store/Android-Password-Store/issues/173#issuecomment-453686599
export GOPASS_GPG_OPTS='--no-throw-keyids'

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

export BEMENU_OPTS="--fn 'monospace 12'"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=15"

setopt HIST_IGNORE_SPACE
HISTORY_IGNORE='(gopass show *|git show *)'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)


alias ghbase="gh pr view --json 'baseRefName' --jq '.baseRefName'"

if test -n "$KITTY_INSTALLATION_DIR"; then
  autoload -U add-zsh-hook

  saved_title=""
  ls_after_cd() {
    local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [ -n "$branch" ]; then
      kitty @ set-window-title "$(basename "$(realpath "$(git rev-parse --git-common-dir --path-format=absolute)/..")")@$branch"
    else
      # Clear the window title so shell integration can set it again
      kitty @ set-window-title --temporary ''
    fi
  }

  # TODO re-enable once kitty detection is done
  add-zsh-hook chpwd ls_after_cd
  add-zsh-hook precmd ls_after_cd
fi

setopt incappendhistory sharehistory
