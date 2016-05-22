if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.config/selfspy.conf ]] && rm ~/.selfspy/selfspy.pid.lock && selfspy -c $HOME/.config/selfspy.conf &
eval $(ssh-agent)
# [[ -f ~/.files/bin/wallpaper.sh ]] && ~/.files/bin/wallpaper.sh &

~/day_wallpapers/wallpaper.sh &
~/.files/bin/panel/lemonbar.sh &

compton &
dunst &
sxhkd &

# exec i3
exec bspwm
