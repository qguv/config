.[]
| select(.focused)
| "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height):\(.name?)"
