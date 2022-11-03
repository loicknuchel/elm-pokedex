module Utils.Set exposing (toggle)

import Set exposing (Set)


toggle : comparable -> Set comparable -> Set comparable
toggle value set =
    if set |> Set.member value then
        set |> Set.remove value

    else
        set |> Set.insert value
