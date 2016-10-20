echo "%{F$titlecol}$title" | awk -v len=100 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
