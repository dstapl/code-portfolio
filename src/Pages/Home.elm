module Pages.Home exposing (view)

import Components.Footer
import Components.Navbar
import Components.ProjectRow
import Html exposing (Html, div, h1, h2, main_, p, section, text)
import Html.Attributes exposing (class, id)
import Pages.About exposing (about)
import Pages.Projects exposing (Project)
import Types exposing (Model, Msg(..))


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
                model.projects
            )
        ]
