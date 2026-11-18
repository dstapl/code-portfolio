port module Main exposing (main)

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


port renderLatex : () -> Cmd msg


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

                        cmd =
                            case maybeProject of
                                Just p ->
                                    if isExpanding then
                                        case (p.longDescription, p.repo) of
                                            (Nothing, Just repoName) ->
                                                -- First time opening: fetch the markdown
                                                Http.get
                                                    { url = "projects/" ++ String.toLower repoName ++ ".md"
                                                    , expect = Http.expectString (GotLongDescription title)
                                                    }

                                            _ ->
                                                -- Already cached: trigger latex render immediately
                                                renderLatex ()
                                    else
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
            -- ( { model | projects = projects }, renderLatex() )

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
            ( { model | projects = updatedProjects }, renderLatex () )

        GotLongDescription _ (Err _) ->
            ( model, Cmd.none )
