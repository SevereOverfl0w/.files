#!/bin/bash
# Open FILE as a new tab in a running nvim and block until the user closes it.
#
#   remote-edit.sh list                -> "<server>\t<cwd>" for each live server
#   remote-edit.sh <file> [server]     -> blocking edit; auto-picks the only live server
#
# Exits non-zero (without opening anything) if the target server is dead, so a
# stale socket can never look like "the user reviewed it".
set -uo pipefail

die() { printf '%s\n' "$@" >&2; exit 1; }

# One line per live nvim *process*: plugins (fzf-lua) open extra sockets onto the
# same instance, so dedupe by pid and keep the socket nvim itself listens on.
live() {
  local s out
  for s in $(nvr --serverlist 2>/dev/null | sort -u); do
    out=$(timeout 3 nvr -s --nostart --servername "$s" --remote-expr 'getpid() . "\t" . getcwd()' 2>/dev/null)
    [ -n "$out" ] && printf '%s\t%s\n' "$out" "$s"
  done | awk -F'\t' '
    !($1 in sock) || $3 ~ /\/nvim[^\/]*$/ { sock[$1] = $3; cwd[$1] = $2 }
    END { for (p in sock) print sock[p] "\t" cwd[p] }' | sort
}

case ${1:-} in
  list) live; exit 0 ;;
  "") die "usage: remote-edit.sh list | remote-edit.sh <file> [server]" ;;
esac

file=$1
server=${2:-}
servers=$(live)
[ -n "$servers" ] || die "no live nvim server"

if [ -n "$server" ]; then
  awk -F'\t' -v s="$server" '$1==s{found=1} END{exit !found}' <<<"$servers" \
    || die "server not live: $server" "live servers:" "$servers"
else
  [ "$(wc -l <<<"$servers")" -eq 1 ] || die "multiple live servers, pass one:" "$servers"
  server=${servers%%$'\t'*}
fi

exec nvr -s --nostart --servername "$server" --remote-tab-wait "$file"
