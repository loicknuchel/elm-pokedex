module Components.Input exposing (DocState, SharedDocState, doc, initDocState, text)

import ElmBook exposing (Msg)
import ElmBook.Actions as Actions
import ElmBook.Chapter as Chapter exposing (Chapter)
import Html exposing (Html, input)
import Html.Attributes exposing (class, id, name, placeholder, type_, value)
import Html.Events exposing (onInput)


text : String -> String -> String -> (String -> msg) -> Html msg
text fieldId fieldPlaceholder fieldValue onChange =
    input
        [ type_ "text"
        , name fieldId
        , id fieldId
        , value fieldValue
        , onInput onChange
        , placeholder fieldPlaceholder
        , class "block rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
        ]
        []



-- DOCUMENTATION


type alias SharedDocState x =
    { x | inputDocState : DocState }


type alias DocState =
    { text : String }


initDocState : DocState
initDocState =
    { text = "" }


updateDocState : (DocState -> DocState) -> Msg (SharedDocState x)
updateDocState transform =
    Actions.updateState (\s -> { s | inputDocState = s.inputDocState |> transform })


doc : Chapter (SharedDocState x)
doc =
    Chapter.chapter "Input"
        |> Chapter.renderStatefulComponentList
            [ ( "text", \{ inputDocState } -> text "id" "ex: bla bla" inputDocState.text (\v -> updateDocState (\s -> { s | text = v })) )
            ]
