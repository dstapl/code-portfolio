module Main exposing (main)

import Browser
import Html exposing (Html)
import Pages.Home


main : Program () () msg
main =
    Browser.sandbox
        { init = ()
        , update = \_ model -> model
        , view = Pages.Home.view
        }
