module Main exposing (main)

import Browser
import Html exposing (Html)
import Http
import Json.Decode as Decode
import Pages.Home
import Pages.Projects as Projects
import Task
import Types exposing (Model, Msg(..))


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = Pages.Home.view
        , subscriptions = \_ -> Sub.none
        }



-- Fetch json for each project


init : () -> ( Model, Cmd Msg )
init _ =
    ( { expandedProject = Nothing
      , projects = []
      }
    , Http.get
        { url = "projects/index.json"
        , expect = Http.expectJson GotProjects (Decode.list Projects.decoder)
        }
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleProject title ->
            let
                isExpanding =
                    model.expandedProject /= Just title

                maybeProject =
                    List.head (List.filter (\p -> p.title == title) model.projects)

                -- Check if we need to fetch and have a repo name to use
                cmd =
                    case maybeProject of
                        Just p ->
                            case ( isExpanding && p.longDescription == Nothing, p.repo ) of
                                ( True, Just repoName ) ->
                                    Http.get
                                        { url = "projects/" ++ String.toLower repoName ++ ".md"
                                        , expect = Http.expectString (GotLongDescription title)
                                        }

                                _ ->
                                    Cmd.none

                        Nothing ->
                            Cmd.none
            in
            ( { model
                | expandedProject =
                    if model.expandedProject == Just title then
                        Nothing

                    else
                        Just title
              }
            , cmd
            )

        GotProjects (Ok projects) ->
            ( { model | projects = projects }, Cmd.none )

        GotProjects (Err _) ->
            ( model, Cmd.none )

        GotLongDescription title (Ok longDesc) ->
            let
                -- Update only the specific project that matches the title
                updatedProjects =
                    List.map
                        (\p ->
                            if p.title == title then
                                { p | longDescription = Just longDesc }

                            else
                                p
                        )
                        model.projects
            in
            ( { model | projects = updatedProjects }, Cmd.none )

        GotLongDescription _ (Err _) ->
            ( model, Cmd.none )
