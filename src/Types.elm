module Types exposing (Model, Msg(..))

import Http
import Pages.Projects exposing (Project)


type alias Model =
    { expandedProject : Maybe String
    , projects : List Project
    }


type Msg
    = ToggleProject String
    | GotProjects (Result Http.Error (List Project))
    | GotLongDescription String (Result Http.Error String) -- Passes the project title and the loaded text/description
