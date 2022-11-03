module Components.Book exposing (DocState, main)

import Components.Badge as Badge
import Components.Button as Button
import Components.Card as Card
import Components.Heading as Heading
import Components.Icon as Icon
import Components.Input as Input
import ElmBook exposing (withChapters)
import ElmBook.StatefulOptions as StatefulOptions


type alias DocState =
    { inputDocState : Input.DocState }


init : DocState
init =
    { inputDocState = Input.initDocState }


main : ElmBook.Book DocState
main =
    ElmBook.book "Pokedex Design System"
        |> ElmBook.withStatefulOptions [ StatefulOptions.initialState init ]
        |> withChapters [ Badge.doc, Button.doc, Card.doc, Heading.doc, Icon.doc, Input.doc ]
