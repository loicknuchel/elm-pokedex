module Components.Button exposing (doc, white3)

import ElmBook.Chapter as Chapter exposing (Chapter)
import Html exposing (Attribute, Html, button, text)
import Html.Attributes exposing (class, type_)


white3 : List (Attribute msg) -> List (Html msg) -> Html msg
white3 attrs children =
    button (attrs ++ [ type_ "button", class "inline-flex items-center rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" ])
        children



-- DOCUMENTATION


doc : Chapter x
doc =
    Chapter.chapter "Button"
        |> Chapter.renderComponentList
            [ ( "white3", white3 [] [ text "Button" ] )
            ]
