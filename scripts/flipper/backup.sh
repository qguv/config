#!/bin/sh
set -e

SSH_KEY='/home/qguv/.config/ssh/id_ed25519'
export GIT_SSH_COMMAND="ssh -o 'StrictHostKeyChecking no' -i '$SSH_KEY'"

dump="$(mktemp -d /tmp/flipper-backup-dump-XXXXX)"
systemd-notify --status="copying files from /media/flippersd to $dump"
rsync --exclude '.Trash-*' --exclude 'nfc/assets/mf_classic_dict.nfc' -av /media/flippersd/ "$dump"

clone="$(mktemp -d /tmp/flipper-backup-clone-XXXXX)"
systemd-notify --status="downloading latest repository to $clone"
git clone --no-checkout --branch sd --depth 1 'ssh://git@github.com/qguv/flipper_sd' "$clone"

systemd-notify --status="setting up new repository in $dump"
mv "$clone/.git" "$dump/.git"
rmdir "$clone"
cd "$dump"
git config core.fileMode false
git config core.ignorecase true
git config core.autocrlf true
git config user.name 'Flipper SD'
git config user.email 'flippersd@guvernator.net'

systemd-notify --status="committing changes"
git add .
git restore --staged .gitignore
git commit -m 'update from SD'

systemd-notify --status="pushing changes"
git push -f origin sd

systemd-notify --status="cleaning up"
rm -rf "$dump"
