module Types exposing (Model, Msg(..))


type alias Model =
    { expandedProject : Maybe String
    }


type Msg
    = ToggleProject String
