module Route exposing (Route(..), fromUrl)

import Url exposing (Url)


type Route
    = Home
    | About
    | Projects
    | NotFound


fromUrl : Url -> Route
fromUrl url =
    let
        path =
            String.dropLeft
                (String.length "/code-portfolio")
                url.path
    in
    case path of
        "/" ->
            Home

        "/about" ->
            About

        "/projects" ->
            Projects

        _ ->
            NotFound
