# show phone when connected

## setup

1. set up `scrcpy`
2. `sudo ln -s "$XDG_CONFIG_HOME"/sway/scripts/m1a_connected/50-m1a.rules /etc/udev/rules.d/50-m1a.rules`
3. `sudo udevadm control --reload`

## how it works

1. `udev` notices that the device is plugged in and checks `/etc/udev/rules.d/` for a matching entry, which it finds in `50-m1a.rules`
2. `udev` tells `systemd` that the device has been seen (`TAG+='systemd'` in `50-m1a.rules`)
3. the `systemd` system service creates a `.device` entry for this device (e.g. `sys-devices-pci0000:00-0000:00:14.0-usb1-1\x2d4-1\x2d4.1.device`) that other services can depend on
4. `systemd` user services update `~/.config/systemd/user/scrcpy.service` to say that the service "wants" this device, or in other words, that the service should start when the device is present (`ENV{SYSTEMD_USER_WANTS}+="scrcpy.service"` in `50-m1a.rules`)
5. `scrcpy.service` starts `~/.config/sway/scripts/m1a_connected/m1a_connected.sh`
6. `m1a_connected.sh` spawns `scrcpy` at the side of the current sway workspace
