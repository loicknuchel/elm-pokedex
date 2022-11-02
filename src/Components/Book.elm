module Components.Book exposing (DocState, main)

import Components.Badge as Badge
import ElmBook exposing (withChapters)


type alias DocState =
    {}


main : ElmBook.Book DocState
main =
    ElmBook.book "Pokedex Design System"
        |> withChapters [ Badge.doc ]
