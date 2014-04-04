#!/bin/sh
#
# Shell script that configures gnome-terminal to use solarized theme
# colors. (I simply replaced in the original script every occurence
# of "gnome-terminal" with "gnome-terminal" and every occurcence
# of "gconftool-2" with "gconftool-2"; reverse these changes if
# using gnome and rename the script to its original name: "solarize"
#
# Written for Ubuntu 11.10, untested on anything else. (actually tested
# also on ArchLinux, seems to work fine here, tweak it to your needs :)
#
# Note that the two last variables i.e. "BG_DARKN" & "BG_TYPE" are only
# for looks and are completely optional; however, if you decide to use
# them, and would like to preserve transparency when launching Vim in a
# terminal, add this to your ~/.vimrc --> let g:solarized_termtrans=1
#
# Read "solarized.txt" for details/explanation (on my system, this file
# is at "/usr/share/vim/vim73/doc/solarized.txt"; I don't know if it is
# the same path on an Ubuntu system but it should be easy to find out.)
#
# Alternatively, visit the link below for further details:
# Solarized theme: http://ethanschoonover.com/solarized
#
# Adapted from these sources:
# https://gist.github.com/1280177
# http://xorcode.com/guides/solarized-vim-eclipse-ubuntu/
# https://gist.github.com/1397104

case "$1" in
        "dark")
                THEME_BG="--set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false"
                THEME_COLOR="false"
                PALETTE="#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
                BG_COLOR="#00002B2B3636"
                FG_COLOR="#65657B7B8383"
                BG_DARKN="0.97"
                BG_TYPE="transparent"
                ;;
        "light")
                THEME_BG="--set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false"
                THEME_COLOR="false"
                PALETTE="#EEEEE8E8D5D5:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#070736364242:#FDFDF6F6E3E3:#CBCB4B4B1616:#9393A1A1A1A1:#838394949696:#65657B7B8383:#6C6C7171C4C4:#58586E6E7575:#00002B2B3636"
                BG_COLOR="#FDFDF6F6E3E3"
                FG_COLOR="#838394949696"
                BG_DARKN="0.91"
                BG_TYPE="transparent"
                ;;
        "unset")
                THEME_BG="--unset /apps/gnome-terminal/profiles/Default/use_theme_background"
                THEME_COLOR="true"
                PALETTE="#2E2E34343636:#CCCC00000000:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8A8AE2E23434:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC"
                BG_COLOR="#FFFFFFFFDDDD"
                FG_COLOR="#000000000000"
                BG_DARKN="0.5"
                BG_TYPE="solid"
                ;;
        *)
        echo "Usage: solarize.sh [light | dark | unset]"
        exit
        ;;
esac

gconftool-2 $THEME_BG
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_colors   --type   bool $THEME_COLOR
gconftool-2 --set /apps/gnome-terminal/profiles/Default/palette            --type string $PALETTE
gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_color   --type string $BG_COLOR
gconftool-2 --set /apps/gnome-terminal/profiles/Default/foreground_color   --type string $FG_COLOR
gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_darkness --type float $BG_DARKN
gconftool-2 --set /apps/gnome-terminal/profiles/Default/background_type    --type string $BG_TYPE
