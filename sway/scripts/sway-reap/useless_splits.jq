recurse(.nodes[])
| select(.type == "con")
| select(.nodes | length == 1)
| .nodes[0]
| .id
