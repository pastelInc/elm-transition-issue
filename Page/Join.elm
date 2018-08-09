module Page.Join exposing (..)

import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Route exposing (Route)


type Model
    = Loaded


type Msg
    = Back


init : Model
init =
    Loaded


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Back ->
            ( model, Route.back )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Join page" ]
        , button [ onClick Back ] [ text "back" ]
        ]
