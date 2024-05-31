#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -f ~/.Xresources ]; then
    xrdb -merge -I$HOME ~/.Xresources
fi

if [ -f ~/.Xresources.local ]; then
    xrdb -merge -I$HOME ~/.Xresources.local
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# test for an existing bus daemon, just to be safe
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && command -v dbus-launch >/dev/null 2>&1; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

command -v xsetroot >/dev/null 2>&1 && xsetroot -cursor_name left_ptr

# Smooth scrolling & touch screen for Firefox
export MOZ_USE_XINPUT2=1

if [ -f ~/.files/bin/wallpaper.sh -a -e ~/Pictures/wallpapers/nord ]; then
  ~/.files/bin/wallpaper.sh ~/Pictures/wallpapers/nord &
fi

runsvdir ~/.files/Xservices/ &
PIDB=$!

command -v start-pulseaudio-x11 >/dev/null 2>&1 && start-pulseaudio-x11

_launch(){
  if `command -v dbus-launch >/dev/null 2>&1`; then
    dbus-launch --exit-with-session "$@"
  else
    "$@"
  fi
}

_launch bspwm

#awesome
#windowchef

# Stop runsv instances in the "right" way.
kill -s HUP "$PIDB"
