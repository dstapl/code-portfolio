module Main exposing (main)

import Browser
import Html exposing (Html)
import Pages.Home
import Types exposing (Model, Msg(..))




main : Program () Model Msg
main =
    Browser.sandbox
        { init = { expandedProject = Nothing }
        , update = update
        , view = Pages.Home.view
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleProject title ->
            { model
                | expandedProject =
                    if model.expandedProject == Just title then
                        Nothing
                    else
                        Just title
            }
