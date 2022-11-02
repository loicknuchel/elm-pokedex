module Components.Badge exposing (doc)

import ElmBook.Chapter as Chapter exposing (Chapter)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


red : String -> Html msg
red v =
    div [ class "inline-flex items-center rounded bg-red-100 px-2 py-0.5 text-xs font-medium text-red-800" ] [ text v ]



-- DOCUMENTATION


doc : Chapter x
doc =
    Chapter.chapter "Badge"
        |> Chapter.renderComponentList
            [ ( "basic", red "red" )
            ]
