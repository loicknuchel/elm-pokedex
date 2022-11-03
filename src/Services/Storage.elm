port module Services.Storage exposing (getFavorites, gotFavorites, setFavorite)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Models.PokemonId exposing (PokemonId)
import Set exposing (Set)
import Utils.Result as Result


getFavorites : Cmd msg
getFavorites =
    getItem "favorites"


gotFavorites : (Result Decode.Error (Set PokemonId) -> msg) -> msg -> Sub msg
gotFavorites toMsg noop =
    gotStoredItem "favorites" decodeFavorites toMsg noop


setFavorite : Set PokemonId -> Cmd msg
setFavorite ids =
    setStoredItem "favorites" encodeFavorites ids


encodeFavorites : Set PokemonId -> Value
encodeFavorites =
    Encode.set Encode.int


decodeFavorites : Decoder (Set PokemonId)
decodeFavorites =
    Decode.maybe (Decode.list Decode.int)
        |> Decode.map (Maybe.map Set.fromList >> Maybe.withDefault Set.empty)


gotStoredItem : String -> Decoder a -> (Result Decode.Error a -> msg) -> msg -> Sub msg
gotStoredItem key decoder toMsg noop =
    gotItem (decodeItem key decoder >> Result.sequenceMaybe >> Maybe.map toMsg >> Maybe.withDefault noop)


setStoredItem : String -> (a -> Value) -> a -> Cmd msg
setStoredItem key encoder a =
    setItem (encodeItem key (a |> encoder))


encodeItem : String -> Value -> Value
encodeItem key value =
    Encode.object
        [ ( "key", key |> Encode.string )
        , ( "value", value )
        ]


decodeItem : String -> Decoder a -> Value -> Result Decode.Error (Maybe a)
decodeItem key decoder =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\k ->
                if k == key then
                    Decode.field "value" decoder |> Decode.map Just

                else
                    Decode.succeed Nothing
            )
        |> Decode.decodeValue


port getItem : String -> Cmd msg


port gotItem : (Value -> msg) -> Sub msg


port setItem : Value -> Cmd msg
