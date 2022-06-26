# normalize root into a structure suitable for recursion
{
    p: []
    , c: .nodes
}

# recurse through children, keeping track of path
| recurse(
    .p as $p
    | .c
    | to_entries[]
    | {p: [$p[], .key], c: .value.nodes, f: .value.focused}
)

# remove irrelevant info
| del(.c)

# get the window in focus
| select(.f)

# get its depth underneath the current workspace
| .p
| length - 2
