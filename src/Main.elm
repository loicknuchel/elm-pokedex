module Main exposing (Flags, Model, Msg, main)

import Browser exposing (Document)
import Html exposing (Html, text)


main : Program Flags Model Msg
main =
    Browser.document { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Flags =
    ()


type alias Model =
    {}


type Msg
    = Noop


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


view : Model -> Document Msg
view _ =
    { title = "Elm Pokedex"
    , body = [ text "Elm Pokedex!" ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
