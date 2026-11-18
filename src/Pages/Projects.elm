-- module Pages.Projects exposing (Project, projects)
--
--
-- type alias Project =
--     { title : String
--     , language : String
--     , shortDescription : Maybe String
--     , longDescription : Maybe String
--     , context : String
--     , source : Maybe String
--     }
--
--
-- githubRepo : String -> Maybe String
-- githubRepo name =
--     Just ("https://github.com/dstapl/" ++ name)
--
-- projects : List Project
-- projects =
--     [ { title = "Direct N-body Simulator"
--       , language = "Fortran"
--       , shortDescription = Just
--             """A gravitational direct N-body simulator, constrained to CPU processing.
--             Taking advantage of SIMD, OpenMP multi-threading, and algorithmic optimisations, to improve performance."""
--       , longDescription = Just "This is a test"
--       , context = "MSc Astrophysics Dissertation"
--       , source = githubRepo "NBODY"
--       }
--     , { title = "CV Classification"
--       , language = "Python · R"
--       , shortDescription = Just
--             """Astronomical photometry and the detection of superhump periodicities in Cataclysmic Variable stars."""
--       , longDescription = Nothing
--       , context = "BSc Research Project"
--       , source = githubRepo "CV-Classification"
--       }
--     , { title = "SIMBAD Object Finder"
--       , language = "Julia"
--       , shortDescription = Just
--             ("An interactive astronomical object filtering tool built using Pluto.jl."
--             ++ " Built to aid first-year telescope observations.")
--       , longDescription = Nothing
--       , context = "Personal Project"
--       , source = githubRepo "SIMBAD-object-finder"
--       }
--     , { title = "Neovim Configuration"
--       , language = "Lua"
--       , shortDescription = Nothing
--       , longDescription = Nothing
--       , context = "Config files"
--       , source = githubRepo "nvimrc"
--       }
--     ]


module Pages.Projects exposing (Project, decoder, listDecoder)

import Json.Decode as Decode exposing (Decoder)



-- TODO: Make "language" a List String, which is concatenated by " · "


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
