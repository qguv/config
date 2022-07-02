recurse(.nodes[], .floating_nodes[])
| select(.focused)
| "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height):\(.app_id?)"
