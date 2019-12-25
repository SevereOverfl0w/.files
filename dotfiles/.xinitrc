#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -f ~/.Xresources ]; then
    xrdb -merge -I$HOME ~/.Xresources
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

xsetroot -cursor_name left_ptr

# If you are using a window manager other than Gnome and have scaled the fonts using Xft.dpi, you must tell GDK to scale the UI as well. This will result in a further increase of the font-size for GDK apps, so you must undo the scaling of the text only. 
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# If you manually set the screen factor, it is important to set QT_AUTO_SCREEN_SCALE_FACTOR=0 otherwise some applications which explicitly force high DPI enabling get scaled twice.
# If you also set the font DPI manually in xrdb to support other toolkits, QT_SCALE_FACTORS will give you huge fonts.
export QT_AUTO_SCREEN_SCALE_FACTOR=1
# export QT_SCALE_FACTOR=1

export ELM_SCALE=2
 
# Smooth scrolling & touch screen for Firefox
export MOZ_USE_XINPUT2=1

if [ -f ~/.files/bin/wallpaper.sh -a -e ~/Pictures/wallpapers/nord ]; then
  ~/.files/bin/wallpaper.sh ~/Pictures/wallpapers/nord &
fi

runsvdir ~/.files/services/ &
PIDA=$!

runsvdir ~/.files/Xservices/ &
PIDB=$!

start-pulseaudio-x11

# sxhkd ~/.config/sxhkd/sxhkdrc &
# sxhkd ~/.config/sxhkd/sxhkdrc_bspwm &
dbus-launch bspwm

#awesome
#windowchef

# Stop runsv instances in the "right" way.
kill -s HUP "$PIDA"
kill -s HUP "$PIDB"
