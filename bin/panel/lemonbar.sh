#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/panel_vars.sh

bspc config top_padding $PANEL_HEIGHT
$DIR/reload.sh | lemonbar -p -f TamzenForPowerline-17 -f FontAwesome-12 -B $dark0_soft -u 2 -U "#f00" | sh
