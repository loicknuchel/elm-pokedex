module Utils.Result exposing (sequenceMaybe)


sequenceMaybe : Result e (Maybe a) -> Maybe (Result e a)
sequenceMaybe r =
    case r of
        Err e ->
            Just (Err e)

        Ok (Just a) ->
            Just (Ok a)

        Ok Nothing ->
            Nothing
