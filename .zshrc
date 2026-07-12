HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

antidote_dir="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
ANTIDOTE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/antidote"
zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins"

if [[ ! -r $antidote_dir/antidote.zsh ]]; then
  mkdir -p -- "${antidote_dir:h}"
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir"
fi

if [[ ! $zsh_plugins.zsh -nt $zsh_plugins.txt ]]; then
  (
    source "$antidote_dir/antidote.zsh"
    antidote bundle <"$zsh_plugins.txt" >"$zsh_plugins.zsh"
  )
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# stop history-substring-search's fallback from clearing autosuggestion highlights.
# https://github.com/zsh-users/zsh-history-substring-search/pull/178
_zsh_highlight() { :; }
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
source ~/.zsh_plugins.zsh
zstyle ':completion::complete:git-switch:*:branch-names' menu yes select=long search
autoload -Uz compinit
compinit
if [[ ! ~/.zcompdump.zwc -nt ~/.zcompdump ]]; then
  zcompile -R -- ~/.zcompdump.zwc ~/.zcompdump
fi

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

alias v="fg %nvim 2>/dev/null || nvim"

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

PATH=$HOME/.local/bin:$HOME/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.cargo/bin:$PATH

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
          local key="$sha (${dir:t})"
          worktrees[$key]="$dir"
        fi
        worktree=()
      fi

    done < <(git worktree list --porcelain)

    IFS=$'\n' local fzfresult=("${(@f)$(print -l "${(@k)worktrees}" | $(__fzfcmd) --query "$LBUFFER" --expect 'ctrl-d,alt-d' --delimiter=' ' --preview-window=down,8 --preview "git worktree list | grep -F '[{1}]'; printf '\n'; git -c color.ui=always lg '{1}'")}")

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

if (( $+commands[gopass] )); then
 gopass_comp="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/gopass-completion.zsh"
 mkdir -p "${gopass_comp:h}"

 if [[ ! -s $gopass_comp || $gopass_comp -ot $commands[gopass] ]]; then
   gopass completion zsh >| "$gopass_comp.tmp" &&
     mv "$gopass_comp.tmp" "$gopass_comp"
 fi

 source "$gopass_comp"
 unset gopass_comp
fi

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line

export BEMENU_OPTS="--fn 'monospace 12'"


setopt HIST_IGNORE_SPACE
HISTORY_IGNORE='(gopass show *|git show *)'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#757575"


alias ghbase="gh pr view --json 'baseRefName' --jq '.baseRefName'"

if test -n "$KITTY_INSTALLATION_DIR"; then
  autoload -U add-zsh-hook

  typeset -g _kitty_title _kitty_title_git_dir
  typeset -gi _kitty_title_set=0 _kitty_title_needs_discovery=1

  _kitty_title_mark_dirty() {
    _kitty_title_needs_discovery=1
  }

  _kitty_title_refresh() {
    local title
    if (( _kitty_title_needs_discovery )); then
      _kitty_title_git_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) ||
        _kitty_title_git_dir=
      _kitty_title_needs_discovery=0
    fi

    if [[ -r ${_kitty_title_git_dir}/HEAD ]]; then
      local head=$(<"${_kitty_title_git_dir}/HEAD")
      if [[ $head == 'ref: refs/heads/'* ]]; then
        title="${_kitty_title_git_dir:h:t}@${head#ref: refs/heads/}"
      else
        title="${_kitty_title_git_dir:h:t}@HEAD"
      fi
    fi

    (( _kitty_title_set )) && [[ $title == $_kitty_title ]] && return
    _kitty_title=$title
    _kitty_title_set=1

    # Kitty remote control waits ~30ms. Title updates must not block prompt redraw.
    if [[ -n $title ]]; then
      command kitty @ set-window-title "$title" >/dev/null 2>&1 &!
    else
      command kitty @ set-window-title --temporary '' >/dev/null 2>&1 &!
    fi
  }

  add-zsh-hook chpwd _kitty_title_mark_dirty
  add-zsh-hook precmd _kitty_title_refresh
fi

setopt incappendhistory sharehistory

# Date aliases for filenames (ISO format)
alias datedate='date +%Y-%m-%d'
alias datetime='date +%Y-%m-%dT%H%M%S'
alias dateweek='date +%Y-W%V'
alias datemonth='date +%Y-%m'
alias mergebase='git oldest-ancestor origin/$(gh pr view --json baseRefName -q .baseRefName 2>/dev/null || printf "master")'
