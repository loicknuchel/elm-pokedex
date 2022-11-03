module Components.Book exposing (DocState, main)

import Components.Badge as Badge
import Components.Button as Button
import Components.Card as Card
import Components.Heading as Heading
import Components.Icon as Icon
import ElmBook exposing (withChapters)


type alias DocState =
    {}


main : ElmBook.Book DocState
main =
    ElmBook.book "Pokedex Design System"
        |> withChapters [ Badge.doc, Button.doc, Card.doc, Heading.doc, Icon.doc ]
