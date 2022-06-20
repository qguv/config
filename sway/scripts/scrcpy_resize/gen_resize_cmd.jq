# get all scrcpy windows
recurse(.nodes[], .floating_nodes[]) | select(.window_properties.class == "scrcpy")

# calculate the width based on the height
| .w = ((.window_rect.height * 598 / 1393) | round)

# account for borders
| .w = .w + (.rect.width - .window_rect.width)

# generate arguments for a swaymsg command
| "[con_id=\(.id)] resize set width \(.w)px"
