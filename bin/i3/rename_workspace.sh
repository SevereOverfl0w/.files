#!/usr/bin/env bash

NAME=$(echo "" | rofi -dmenu -p "New name: ")
~/.files/bin/i3/rename_workspace "$NAME"
