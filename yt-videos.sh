#!/bin/sh

DEFAULT_FORMAT="-f 135+140"

URL="$1"

ARGS=${DEFAULT_FORMAT}
if [ -n "$2" ]; then
	shift
	ARGS="$@"
fi

CMD=". ~/.profile; yt-dlp \"${URL}\" --cookies ~/cookies.txt ${ARGS}  --paths ~/Videos"

echo $CMD

ssh djn@ 'scp ~/Downloads/cookies.txt djn@:'
ssh djn@ "$CMD"
