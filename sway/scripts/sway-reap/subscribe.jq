(
    select(.change == "run")
    | .binding.command
    | (
        (
            select(
                contains("splith")
                or contains("splitv")
            )
            | "split"
        )
        , (
            select(contains("layout"))
            | "layout"
        )
    )
)
// .change
