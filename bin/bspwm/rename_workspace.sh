NAME=$(rofi -dmenu -p "New name: " < ~/.files/workspaces.txt)

if [ -n "$NAME" ]; then
  bspc desktop -n "$NAME"
fi
