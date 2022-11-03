module Main exposing (Flags, Model, Msg, main)

import Browser exposing (Document)
import Components.Button as Button
import Components.Card as Card
import Components.Heading as Heading
import Components.Icon as Icon
import Dict exposing (Dict)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Models.Pokemon exposing (Pokemon)
import Models.PokemonId exposing (PokemonId)
import Random
import Services.PokeApi as PokeApi exposing (ItemList, PokemonListUrl, PokemonUrl)
import Services.Storage as Storage
import Set exposing (Set)
import Utils.Set as Set


main : Program Flags Model Msg
main =
    Browser.document { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Flags =
    ()


type alias Model =
    { pokemons : Dict PokemonId Pokemon
    , more : Maybe PokemonListUrl
    , selected : Maybe Pokemon
    , favorites : Set PokemonId
    , search : String
    }


type Msg
    = GetPokemonList PokemonListUrl
    | GotPokemonList (Result Http.Error (ItemList PokemonListUrl PokemonUrl))
    | GotPokemon (Result Http.Error Pokemon)
    | SelectPokemon Pokemon
    | UnselectPokemon
    | GotFavorites (Result Decode.Error (Set PokemonId))
    | ToggleFavorite PokemonId
    | RandomPokemon
    | ChangeSearch String
    | Noop


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { pokemons = Dict.empty
      , more = Nothing
      , selected = Nothing
      , favorites = Set.empty
      , search = ""
      }
    , Cmd.batch
        [ PokeApi.firstPokemons GotPokemonList
        , Storage.getFavorites
        ]
    )


view : Model -> Document Msg
view model =
    { title = "Elm Pokedex"
    , body =
        [ viewHeader model.search
        , model.selected |> Maybe.map (viewPokemonDetails model.favorites) |> Maybe.withDefault (viewPokemonList model)
        ]
    }


viewHeader : String -> Html Msg
viewHeader search =
    div [ class "mt-6 mb-12 mx-auto max-w-5xl" ]
        [ Heading.simple
            { title = "Elm Pokedex"
            , search = { value = search, onChange = ChangeSearch }
            , actions = [ Button.white3 [ onClick RandomPokemon ] [ text "View random" ] ]
            }
        ]


viewPokemonList : Model -> Html Msg
viewPokemonList model =
    div []
        [ model.pokemons
            |> Dict.values
            |> List.filter (\p -> p.name |> String.contains model.search)
            |> List.sortBy .id
            |> List.map (viewPokemonItem model.favorites)
            |> Card.teamGrid
        , viewLoadMore model.more
        ]


viewPokemonItem : Set PokemonId -> Pokemon -> Html Msg
viewPokemonItem favorites pokemon =
    div [ onClick (SelectPokemon pokemon), class "cursor-pointer" ]
        [ Card.team
            { name =
                pokemon.name
                    ++ (if favorites |> Set.member pokemon.id then
                            " *"

                        else
                            ""
                       )
            , title = pokemon.types |> String.join " / "
            , picture = pokemon.sprites.front
            , pictureAlt = pokemon.sprites.back
            }
        ]


viewLoadMore : Maybe PokemonListUrl -> Html Msg
viewLoadMore more =
    let
        attr : Attribute Msg
        attr =
            more
                |> Maybe.map (\url -> onClick (GetPokemonList url))
                |> Maybe.withDefault (style "display" "hidden")
    in
    div [ class "my-24 text-center" ]
        [ Button.white3 [ attr ] [ text "Load more" ]
        ]


viewPokemonDetails : Set PokemonId -> Pokemon -> Html Msg
viewPokemonDetails favorites pokemon =
    Heading.heading
        { banner = "/assets/" ++ (pokemon.types |> List.head |> Maybe.withDefault "unknown") ++ "_banner.jpg"
        , picture = pokemon.sprites.front
        , pictureAlt = pokemon.sprites.back
        , name = pokemon.name
        , actions =
            [ if favorites |> Set.member pokemon.id then
                Button.white3 [ onClick (ToggleFavorite pokemon.id) ] [ Icon.starSolid "mr-1", text "Starred" ]

              else
                Button.white3 [ onClick (ToggleFavorite pokemon.id) ] [ Icon.starOutline "mr-1", text "Star" ]
            , Button.white3 [ onClick UnselectPokemon ] [ text "Close" ]
            ]
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPokemonList url ->
            ( { model | more = Nothing }, PokeApi.listPokemons GotPokemonList url )

        GotPokemonList res ->
            ( { model | more = res |> Result.map .next |> Result.withDefault Nothing }
            , Cmd.batch (res |> Result.map (.results >> List.map (.url >> PokeApi.getPokemon GotPokemon)) |> Result.withDefault [])
            )

        GotPokemon res ->
            ( res |> Result.map (\pokemon -> { model | pokemons = model.pokemons |> Dict.insert pokemon.id pokemon }) |> Result.withDefault model, Cmd.none )

        SelectPokemon pokemon ->
            ( { model | selected = Just pokemon }, Cmd.none )

        UnselectPokemon ->
            ( { model | selected = Nothing }, Cmd.none )

        GotFavorites res ->
            ( res |> Result.map (\ids -> { model | favorites = ids }) |> Result.withDefault model, Cmd.none )

        ToggleFavorite id ->
            ( model, model.favorites |> Set.toggle id |> Storage.setFavorite )

        RandomPokemon ->
            case model.pokemons |> Dict.values of
                [] ->
                    ( model, Cmd.none )

                head :: tail ->
                    ( model, Random.generate SelectPokemon (Random.uniform head tail) )

        ChangeSearch value ->
            ( { model | search = value }, Cmd.none )

        Noop ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Storage.gotFavorites GotFavorites Noop
