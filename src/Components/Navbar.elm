module Components.Navbar exposing (view)

import Html exposing (Html, a, header, nav, text)
import Html.Attributes exposing (class, href, target)


view : Html msg
view =
    header [ class "navbar" ]
        [ a [ class "site-logo", href "#top" ]
            [ text "dstapl" ]
        , nav [ class "nav-links" ]
            [ a [ href "#projects" ] [ text "Projects" ]
            , a
                [ href "https://github.com/dstapl"
                , target "_blank"
                ]
                [ text "GitHub ↗" ]
            ]
        ]

