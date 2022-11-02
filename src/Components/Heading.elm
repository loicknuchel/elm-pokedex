module Components.Heading exposing (HeadingModel, doc, heading)

import Components.Button as Button
import ElmBook exposing (Msg)
import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter as Chapter exposing (Chapter)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)


type alias HeadingModel msg =
    { banner : String
    , picture : String
    , pictureAlt : String
    , name : String
    , actions : List (Html msg)
    }


heading : HeadingModel msg -> Html msg
heading model =
    div []
        [ div [] [ img [ class "h-32 w-full object-cover lg:h-48", src model.banner, alt "" ] [] ]
        , div [ class "mx-auto max-w-5xl px-4 sm:px-6 lg:px-8" ]
            [ div [ class "-mt-12 sm:-mt-16 sm:flex sm:items-end sm:space-x-5" ]
                [ div [ class "flex group" ]
                    [ img [ class "h-24 w-24 rounded-full bg-white ring-4 ring-white sm:h-32 sm:w-32 block group-hover:hidden", src model.picture, alt "" ] []
                    , img [ class "h-24 w-24 rounded-full bg-white ring-4 ring-white sm:h-32 sm:w-32 hidden group-hover:block", src model.pictureAlt, alt "" ] []
                    ]
                , div [ class "mt-6 sm:flex sm:min-w-0 sm:flex-1 sm:items-center sm:justify-end sm:space-x-6 sm:pb-1" ]
                    [ div [ class "mt-6 min-w-0 flex-1 sm:hidden md:block" ]
                        [ h1 [ class "capitalize truncate text-2xl font-bold text-gray-900" ] [ text model.name ] ]
                    , div [ class "justify-stretch mt-6 flex flex-col space-y-3 sm:flex-row sm:space-y-0 sm:space-x-4" ] model.actions
                    ]
                ]
            , div [ class "mt-6 hidden min-w-0 flex-1 sm:block md:hidden" ]
                [ h1 [ class "capitalize truncate text-2xl font-bold text-gray-900" ] [ text model.name ] ]
            ]
        ]



-- DOCUMENTATION


sampleHeading : HeadingModel (Msg state)
sampleHeading =
    { banner = "https://images.unsplash.com/photo-1444628838545-ac4016a5418a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
    , picture = "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , name = "Ricardo Cooper"
    , actions =
        [ Button.white3 [ onClick (logAction "Message clicked") ] [ text "Message" ]
        , Button.white3 [ onClick (logAction "Call clicked") ] [ text "Call" ]
        ]
    }


doc : Chapter x
doc =
    Chapter.chapter "Heading"
        |> Chapter.renderComponentList
            [ ( "heading", heading sampleHeading )
            ]
