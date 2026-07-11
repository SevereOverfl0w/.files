#!/usr/bin/env bash

# Organize the emails
/usr/bin/imapfilter -c ~/.config/imapfilter/work.lua
# Pull email down, if imapfilter succeeded
if [ $? -eq 0 ]; then
  /usr/bin/mbsync -Va
fi

exit 0
