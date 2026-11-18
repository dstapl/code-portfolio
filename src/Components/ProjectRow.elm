-- module Components.ProjectRow exposing (view)
--
-- import Pages.Projects exposing (Project)
-- import Html exposing (Html, a, div, h3, p, span, text)
-- import Html.Attributes exposing (class, href, rel, target)
--
--
-- view : Project -> Html msg
-- view project =
--     div [ class "project-row" ]
--         [ div [ class "project-heading" ]
--             [ div [ class "project-title-group" ]
--                 [ h3 [] [ text project.title ]
--                 , case project.source of
--                     Just url ->
--                         a
--                             [ class "project-source"
--                             , href url
--                             , target "_blank"
--                             , rel "noopener noreferrer"
--                             ]
--                             [ text "Source ↗" ]
--
--                     Nothing ->
--                         text ""
--                 ]
--             , span [ class "project-language" ]
--                 [ text project.language ]
--             ]
--         , div [ class "project-meta" ]
--             [ text project.context ]
--         , p [ class "project-description" ]
--             [ text project.description ]
--         ]


module Components.ProjectRow exposing (view)

import Pages.Projects exposing (Project)
import Html exposing (Html, a, button, div, h3, p, span, text)
import Html.Attributes exposing (class, href, rel, target, type_, attribute)
import Html.Events exposing (onClick)


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
                (if expanded then "true" else "false")
            ]
            [ div [ class "project-heading" ]
                [ div [ class "project-title-group" ]
                    [ h3 [] [ text project.title ]
                    ]
                , span [ class "project-language" ]
                    [ text project.language ]
                ]
            , div [ class "project-meta" ]
                [ text project.context ]
            , case project.shortDescription of
                Just description ->
                    p [ class "project-description" ]
                        [ text description ]

                Nothing ->
                    text ""
            ]

        , if expanded then
            div [ class "project-details" ]
                [ case project.longDescription of
                    Just description ->
                        p [ class "project-long-description" ]
                            [ text description ]

                    Nothing ->
                        text ""
                , case project.source of
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
