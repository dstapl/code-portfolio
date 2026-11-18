module Pages.Home exposing (view)

import Types exposing (Model, Msg(..))
import Components.Footer
import Components.Navbar
import Components.ProjectRow
import Pages.Projects exposing (projects)
import Html exposing (Html, div, h2, main_, section, text)
import Html.Attributes exposing (class, id)
import Pages.About exposing (about)
import Html exposing (h1, p)


-- view : Model -> Html msg
view : Model -> Html Msg
view model =
    div [ class "site-shell" ]
        [ Components.Navbar.view
        , main_ [ class "main-content", id "top" ]
            [ aboutSection
            , projectsSection model
            ]
        , Components.Footer.view
        ]


-- aboutSection : Html msg
aboutSection : Html Msg
aboutSection =
    section [ class "intro" ]
        [ h1 [] [ text about.name ]
        , p [ class "intro-subtitle" ]
            [ text about.subtitle ]
        , div []
            (List.map
                (\paragraph ->
                    p [ class "intro-description" ] [ text paragraph ]
                )
                about.paragraphs
            )
        ]


-- projectsSection : Html msg
-- projectsSection =
--     section [ class "projects-section", id "projects" ]
--         [ h2 [ class "section-heading" ] [ text "Projects" ]
--         , div [ class "project-list" ]
--             (List.map Components.ProjectRow.view projects)
--         ]


projectsSection : Model -> Html Msg
projectsSection model =
    section [ class "projects-section", id "projects" ]
        [ h2 [ class "section-heading" ] [ text "Projects" ]
        , div [ class "project-list" ]
            (List.map
                (\project ->
                    Components.ProjectRow.view
                        ToggleProject
                        (model.expandedProject == Just project.title)
                        project
                )
                projects
            )
        ]
