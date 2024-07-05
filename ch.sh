#!/bin/bash

if ! command -v jq &>/dev/null; then
  echo "This utility requires jq."
  exit 1
fi

CONFIGFILE=~/.ch.config.json
DEFAULT_CONFIGFILE=./.ch.config.json

if test -f "$CONFIGFILE"; then
  echo "user config exists"
else
  #make sure the default file exists too
  if test -f "$DEFAULT_CONFIGFILE"; then
    CONFIGFILE="$DEFAULT_CONFIGFILE"
  else
    echo "Aw nuts... cannot find user config or default config."
    exit 1
  fi
fi

FOO='raid'
jq -r --arg WORD "$1" '.commands[] | select(.keywords|test($WORD)) | .' $CONFIGFILE
