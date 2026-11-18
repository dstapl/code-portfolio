module Components.ProjectRow exposing (view)

import Html exposing (Html, a, button, div, h3, p, span, text, node)
import Html.Attributes exposing (attribute, class, href, rel, target, type_)
import Html.Events exposing (onClick)
import Markdown
import Pages.Projects exposing (Project)


githubRepo : String -> Maybe String
githubRepo name =
    Just ("https://github.com/dstapl/" ++ name)


view : (String -> msg) -> Bool -> Project -> Html msg
view toggle expanded project =
    div
        [ class
            (if expanded then
                "project-row expanded"

             else
                "project-row"
            )
        ]
        [ button
            [ class "project-toggle"
            , type_ "button"
            , onClick (toggle project.title)
            , attribute "aria-expanded"
                (if expanded then
                    "true"

                 else
                    "false"
                )
            ]
            [ div [ class "project-heading" ]
                [ div [ class "project-title-group" ]
                    [ h3 [] [ text project.title ]
                    ]
                , span [ class "project-language" ]
                    -- [ text project.language ]
                    [ text (String.join " · " project.language) ]
                ]
            , div [ class "project-meta" ]
                [ text project.context ]
            , case project.shortDescription of
                Just description ->
                    node "latex-content"
                        []
                        [ Markdown.toHtml [] description ]

                Nothing ->
                    text ""
            ]
        , if expanded then
            div [ class "project-details" ]
                [ case project.longDescription of
                    Just description ->
                        node "latex-content"
                            [ class "project-long-description" ]
                            [ Markdown.toHtml [] description ]

                    Nothing ->
                        text ""
                , case project.repo |> Maybe.andThen githubRepo of
                    Just url ->
                        a
                            [ class "project-source"
                            , href url
                            , target "_blank"
                            , rel "noopener noreferrer"
                            ]
                            [ text "View source ↗" ]

                    Nothing ->
                        text ""
                ]

          else
            text ""
        ]
