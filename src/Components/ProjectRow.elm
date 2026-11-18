module Components.ProjectRow exposing (view)

import Pages.Projects exposing (Project)
import Html exposing (Html, a, div, h3, p, span, text)
import Html.Attributes exposing (class, href, rel, target)


view : Project -> Html msg
view project =
    div [ class "project-row" ]
        [ div [ class "project-heading" ]
            [ div [ class "project-title-group" ]
                [ h3 [] [ text project.title ]
                , case project.source of
                    Just url ->
                        a
                            [ class "project-source"
                            , href url
                            , target "_blank"
                            , rel "noopener noreferrer"
                            ]
                            [ text "Source ↗" ]

                    Nothing ->
                        text ""
                ]
            , span [ class "project-language" ]
                [ text project.language ]
            ]
        , div [ class "project-meta" ]
            [ text project.context ]
        , p [ class "project-description" ]
            [ text project.description ]
        ]
