#!/bin/sh

SOURCE="/volume1/video/tv"
DEST="/volume1/video/tv-index"
LN="../../tv"
SEDSRC=$(echo $SOURCE| sed 's/\//\\\//g')

cd "$SOURCE"
IFS=$(echo -en "\n\b")
for FILE in $(find $SOURCE -regex '.*\.\(avi\|mkv\|srt\)$' | grep -vi sample); do
  DIR=$(dirname "$FILE")
  AVI=$(basename "$FILE")
  SERIE=$(echo "$AVI" | sed 's/\.\([sS]\|Part\)\{0,1\}[0-9]\{1,2\}[eExX]\{0,1\}[0-9]\{1,3\}.*//' | grep -iv '\(avi\|mkv\|srt\)$')
  if [ "$SERIE" != "" ]; then
    if [ ! -d "${DEST}/${SERIE}" ]; then
      mkdir "${DEST}/${SERIE}"
    fi
    if [ ! -f "${DEST}/${SERIE}/${AVI}" ]; then
      ln -s "${LN}$(echo "$FILE" | sed "s/${SEDSRC}//")" "${DEST}/${SERIE}/${AVI}"
    fi
  fi
done
