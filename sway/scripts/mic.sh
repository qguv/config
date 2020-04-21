#!/bin/sh
set -eo pipefail

if amixer get Capture | grep -F '[off]' > /dev/null; then
    echo '🙊' > /tmp/mic
else
    echo '🎙️' > /tmp/mic
fi
