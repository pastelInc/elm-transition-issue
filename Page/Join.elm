module Page.Join exposing (..)

import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Route exposing (Route)


type Model
    = Loaded


type Msg
    = Back
    | Crash


init : Model
init =
    Loaded


{-| Crash msg is executed instead of Unfocus msg. But Unfocus msg is undefined in this page.
This is occurred when onBlur and onEnter were triggered in Home page.
Because case syntax is translate to if (or switch) syntax (Crash msg is translated to default syntax).
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Back ->
            ( model, Route.back )

        Crash ->
            Debug.crash "This msg don't be used, but be executed."


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Join page" ]
        , button [ onClick Back ] [ text "back" ]
        ]
