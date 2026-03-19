#!/bin/sh

DEFAULT_FORMAT="-f 135+140-19"

URL="$1"

ARGS=${DEFAULT_FORMAT}
if [ -n "$2" ]; then
	shift
	ARGS="$@"
fi

CMD=". ~/pyyt/bin/activate; yt-dlp \"${URL}\" --cookies ~/cookies.txt ${ARGS}  --paths ~/Videos  --js-runtimes 'bun:/home/djn/.bun/bin/bun'"

echo $CMD

scp ~/Downloads/cookies.txt djn@ytproxy:
ssh djn@ytproxy "$CMD"
