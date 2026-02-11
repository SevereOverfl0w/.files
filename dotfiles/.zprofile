unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
# fi
# This seems to break GPG:
# export GPG_TTY=$(tty)
# don't think I need this:
#gpg-connect-agent updatestartuptty /bye >/dev/null
# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

for E in ~/.config/service-env/*; do
  export "$(basename "$E")=$(cat "$E")"
done
