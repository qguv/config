# backup Flipper Zero SD card when connected

## setup

1. install systemd services
  - `sudo cp -t /etc/systemd/system "$XDG_CONFIG_HOME"/systemd/system/*flipper*`
  - `sudo systemctl daemon-reload`
  - `sudo systemctl enable --now media-flippersd.automount`
2. customize your script
  - update `SSH_KEY` in `backup.sh`
3. customize udev rule
  - plug in your memory card
  - `sudo udevadm info --attribute-walk /dev/mmcblk0p1 | grep 'ATTRS{serial}'`
  - replace the serial number in 50-flippersd.rules
  - remove memory card
  - customize your script
4. install udev rule
  - `sudo ln -s "$XDG_CONFIG_HOME"/scripts/flipper/50-flippersd.rules /etc/udev/rules.d/50-flippersd.rules`
  - `sudo udevadm control --reload`

Now, insert your memory card and test it out!

## how it works

1. `udev` notices that the device is plugged in and checks `/etc/udev/rules.d/` for a matching entry, which it finds in `50-flippersd.rules`
2. `udev` tells `systemd` that the device has been seen (`TAG+='systemd'` in `50-flippersd.rules`)
3. the `systemd` system service creates a `.device` entry for this device (e.g. `sys-devices-pci0000:00-0000:00:1d.0-0000:39:00.0-rtsx_pci_sdmmc.0-mmc_host-mmc0-mmc0:1234-block-mmcblk0-mmcblk0p1.device`) that other services can depend on
4. the `systemd` system service updates `/etc/systemd/system/backup-flipper.service` to say that the service "wants" this device, or in other words, that the service should start when the device is present (`ENV{SYSTEMD_WANTS}+="backup-flipper.service"` in `50-flippersd.rules`)
5. `backup-flipper.service` starts `~/.config/sway/scripts/flipper/backup.sh`
6. `~/.config/sway/scripts/flipper/backup.sh` accesses `/media/flippersd`
7. the `systemd` system service sees the access of `/media/flippersd` which is controlled by the now-active `media-flipper.automount`
8. the `systemd` system service starts `media-flipper.mount`, which mounts the path
9. `backup.sh` copies the files from the sdcard into a temporary directory
- 10 seconds after the last file is copied, `systemd` sees that the device isn't being accessed anymore, and unmounts it by stopping `media-flippersd.mount`
10. `backup.sh` downloads the `sd` branch of the repository into a temporary directory
11. `backup.sh` pushes a commit that replaces all files in the repo with the ones from the sdcard
