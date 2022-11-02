module Services.PokeApi exposing (ItemList, PokemonListUrl, PokemonUrl, firstPokemons, getPokemon, listPokemons)

import Http
import Json.Decode as Decode exposing (Decoder)
import Models.Pokemon exposing (Pokemon)


type alias ItemList listUrl itemUrl =
    { count : Int
    , next : Maybe listUrl
    , previous : Maybe listUrl
    , results : List { name : String, url : itemUrl }
    }


type PokemonListUrl
    = PokemonListUrl String


type PokemonUrl
    = PokemonUrl String


firstPokemons : (Result Http.Error (ItemList PokemonListUrl PokemonUrl) -> msg) -> Cmd msg
firstPokemons toMsg =
    listPokemons toMsg (PokemonListUrl "https://pokeapi.co/api/v2/pokemon?limit=12")


listPokemons : (Result Http.Error (ItemList PokemonListUrl PokemonUrl) -> msg) -> PokemonListUrl -> Cmd msg
listPokemons toMsg (PokemonListUrl url) =
    Http.get { url = url, expect = Http.expectJson toMsg (decodeItemList PokemonListUrl PokemonUrl) }


getPokemon : (Result Http.Error Pokemon -> msg) -> PokemonUrl -> Cmd msg
getPokemon toMsg (PokemonUrl url) =
    Http.get { url = url, expect = Http.expectJson toMsg decodePokemon }


decodeItemList : (String -> listUrl) -> (String -> itemUrl) -> Decoder (ItemList listUrl itemUrl)
decodeItemList toListUrl toItemUrl =
    Decode.map4 ItemList
        (Decode.field "count" Decode.int)
        (Decode.field "next" (Decode.maybe Decode.string |> Decode.map (Maybe.map toListUrl)))
        (Decode.field "previous" (Decode.maybe Decode.string |> Decode.map (Maybe.map toListUrl)))
        (Decode.field "results" (Decode.list (decodeItem toItemUrl)))


decodeItem : (String -> itemUrl) -> Decoder { name : String, url : itemUrl }
decodeItem toItemUrl =
    Decode.map2 (\name url -> { name = name, url = url })
        (Decode.field "name" Decode.string)
        (Decode.field "url" Decode.string |> Decode.map toItemUrl)


decodePokemon : Decoder Pokemon
decodePokemon =
    Decode.map4 Pokemon
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "sprites" decodePokemonSprite)
        (Decode.field "types" (Decode.list (Decode.field "type" (Decode.field "name" Decode.string))))


decodePokemonSprite : Decoder { front : String, back : String }
decodePokemonSprite =
    Decode.map2 (\front back -> { front = front, back = back })
        (Decode.field "front_default" Decode.string)
        (Decode.field "back_default" Decode.string)
