module Pages.Projects exposing (Project, decoder, listDecoder)

import Json.Decode as Decode exposing (Decoder)


type alias Project =
    { title : String

    -- , language : String
    , language : List String
    , shortDescription : Maybe String
    , longDescription : Maybe String
    , context : String
    , repo : Maybe String
    }


decoder : Decoder Project
decoder =
    Decode.map6 Project
        (Decode.field "title" Decode.string)
        (Decode.field "language" (Decode.list Decode.string))
        (Decode.field "shortDescription" (Decode.nullable Decode.string))
        (Decode.succeed Nothing)
        -- Starts as Nothing until fetched on expand!
        (Decode.field "context" Decode.string)
        (Decode.field "repo" (Decode.nullable Decode.string))


listDecoder : Decoder (List Project)
listDecoder =
    Decode.list decoder
