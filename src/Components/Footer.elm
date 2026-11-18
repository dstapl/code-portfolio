module Components.Footer exposing (view)

import Html exposing (Html, a, footer, span, text)
import Html.Attributes exposing (class, href, target)


view : Html msg
view =
    footer [ class "footer" ]
        [ span [] [ text "© 2026 Daniel Stapleton" ]
        , a
            [ href "https://github.com/dstapl"
            , target "_blank"
            ]
            [ text "GitHub ↗" ]
        ]
