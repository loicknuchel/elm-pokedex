module Models.Pokemon exposing (Pokemon)

import Models.PokemonId exposing (PokemonId)


type alias Pokemon =
    { id : PokemonId
    , name : String
    , sprites : { front : String, back : String }
    , types : List String
    }
