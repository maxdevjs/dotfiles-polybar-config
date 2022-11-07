#!/usr/bin/env sh

# Original
# https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/notification-reddit

# https://www.reddit.com/prefs/feeds/
#URL="https://www.reddit.com/message/unread/.json?feed=809e2cc160a1da442266fec299d690734610ff26&user=maxdevjs"
URL=$(cat $HOME/Me/tokens/reddit-url)
USERAGENT="polybar-scripts/notification-reddit:v1.0 u/reddituser"

NOTIFICATIONS=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

BG_COLOR=#ffb52a
FG_COLOR=#0a0a1a
FG_COLOR_OFFLINE=#3b4252

RESULT=$(system-network-online-offline)

if [ "$RESULT" ]
then
  if [ -n "$NOTIFICATIONS" ] && [ "$NOTIFICATIONS" -gt 0 ]; then
    # There are new notifications
    #echo "%{B$BG_COLOR F$FG_COLOR} 樓 $NOTIFICATIONS %{B- F-}" 
    echo "%{B$BG_COLOR F$FG_COLOR} 樓 %{B- F-}" 
  else
    # There are not new notifications
    echo "樓"
  fi
else
  # Offline
  echo "%{F$FG_COLOR_OFFLINE} 樓 %{F-}"
fi
