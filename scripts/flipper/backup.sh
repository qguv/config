#!/bin/sh
set -e

log() {
    printf '%s\n' "$*" >&2
    if [ -n "$NOTIFY_SOCKET" ]; then
        systemd-notify "--status=$*"
    fi
}

SSH_KEY='/home/qguv/.config/ssh/id_ed25519'
export GIT_SSH_COMMAND="ssh -o 'StrictHostKeyChecking no' -i '$SSH_KEY'"

dump="$(mktemp -d /tmp/flipper-backup-dump-XXXXX)"
log "copying files from /media/flippersd to $dump"
rsync --exclude '.Trash-*' -av /media/flippersd/ "$dump"

clone="$(mktemp -d /tmp/flipper-backup-clone-XXXXX)"
log "downloading latest repository to $clone"
git clone --no-checkout --branch sd --depth 1 'ssh://git@github.com/qguv/flipper_sd' "$clone"

log "setting up new repository in $dump"
mv "$clone/.git" "$dump/.git"
rmdir "$clone"
cd "$dump"
git config core.fileMode false
git config core.ignorecase true
git config core.autocrlf true
git config user.name 'Flipper SD'
git config user.email 'flippersd@guvernator.net'

log "checking for changes"
git add .
git restore --staged .gitignore

if git diff --cached --exit-code --quiet; then
    printf '%s\n' "no changes!"
else
    log "committing changes"
    git commit -m 'update from SD'

    log "pushing changes"
    git push -f origin sd
fi

log "cleaning up"
rm -rf "$dump"
