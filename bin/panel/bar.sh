#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/panel_vars.sh

# Bash Utils {{{
containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}
# }}}

# Lemonbar Utils {{{
FG() {
        # echo $1
        HEX=$1
        shift
        echo "%{F$HEX}$@%{F-}"
}

BG() {
        HEX=$1
        shift
        echo "%{B$HEX}$@%{B-}"
}

UNDERLINE() {
        HEX=$1
        shift
        echo "%{U$HEX}%{+u}$@%{-u}%{U-}"
}

REV() {
        echo "%{R}$@%{R}"
}

LEFT="%{l}"
CENTER="%{c}"
RIGHT="%{r}"
# }}}

# {{{ Components
Clock() {
        DATETIME=$(date "+%a %b %d, %T")
        echo -n " $DATETIME"
}

Volume() {
        echo " $(amixer get Master | sed -n 's/^.*\[\([0-9]\+%\).*$/\1/p')"
}

Battery() {
        BATPERC=$(cat /sys/class/power_supply/BAT0/capacity)

        case $(cat /sys/class/power_supply/BAT0/status) in
                Full)
                        ICON=""
                        ;;
                Charging)
                        ICON=""
                        ;;
                Discharging)
                        ICON=""
                        ;;
                *)
                        ICON="??"
        esac
        echo "$ICON $BATPERC%"
}

Workspace() {
        BG=$faded_aqua

        oldifs=$IFS
        IFS=$'\n'

        ACTIVE=( $(bspc query -D -d .focused) )
        OCCUPIED=( $(bspc query -D -d .occupied) )
        ALL=( $(bspc query -D) )

        IFS=$oldifs

        COUNTER=1
        for D in ${ALL[@]}
        do
                WORKSPACE="$COUNTER:%{A:bspc desktop -f $D:}$D%{A}"
                if $(containsElement "$D" "${OCCUPIED[@]}" || [ "$D" = "$ACTIVE" ]); then
                        if [ "$D" = "$ACTIVE" ]; then
                                echo -n "$(BG $bright_aqua $WORKSPACE)%{B$BG} "
                        else
                                echo -n "%{B$BG}$WORKSPACE "
                        fi
                fi
                let COUNTER=COUNTER+1
        done
        echo -n "$(FG $dark0_hard)%{B-}$(BG $neutral_aqua $(FG $BG $sep_right))$(FG $neutral_aqua $sep_right)%{F-}"
        # echo -n "$(FG $dark0_hard)%{B-}$(FG $BG $sep_right)"
}

Wifi() {
        NETWORK=$(iwgetid -r)
        COLOR=$bright_green
        if [ -z "$NETWORK" ]; then
                NETWORK="Disconnected"
                COLOR=$bright_red
        fi
        echo "$(FG $COLOR  $NETWORK)"
}

# }}}

# Ordering controls overlays (titles are unimportant)
barcontent="%{F$light0}$LEFT$(xtitle -i)$RIGHT$(FG $bright_orange $(Clock)) $(FG $bright_blue $(Volume)) $(FG $bright_yellow $(Battery)) $(Wifi)"

Monitors=$(xrandr | grep -o "^.* connected" | sed "s/ connected//")
tmp=0
for m in $(echo "$Monitors"); do
    barout+="%{S${tmp}}$barcontent"
    let tmp=$tmp+1
done

echo $barout
