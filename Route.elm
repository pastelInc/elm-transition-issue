module Route exposing (Route(..), back, fromLocation, newUrl)

import Navigation
import UrlParser as Url exposing ((</>), (<?>), Parser)


type Route
    = Home
    | Join


route : Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home (Url.s "")
        , Url.map Join (Url.s "join")
        ]


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            "/"

        Join ->
            "/join"



-- PUBLIC HELPERS --


fromLocation : Navigation.Location -> Route
fromLocation location =
    case Url.parsePath route location of
        Just route ->
            route

        Nothing ->
            Home


newUrl : Route -> Cmd msg
newUrl =
    routeToString >> Navigation.newUrl


back : Cmd msg
back =
    Navigation.back 1
