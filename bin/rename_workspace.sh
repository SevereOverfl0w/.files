#!/usr/bin/env bash

NAME=$(echo "" | rofi -dmenu -p "New name: ")
~/.files/bin/rename_workspace "$NAME"
