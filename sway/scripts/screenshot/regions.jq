[
    recurse(.nodes[], .floating_nodes[])
    | select(.rect?)
    | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height):\(.app_id?)"
]
| unique
| .[]
