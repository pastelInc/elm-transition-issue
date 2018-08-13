module Page.Home exposing (..)

import Html exposing (Attribute, Html, button, div, h1, input, text)
import Html.Attributes exposing (placeholder, style, type_)
import Html.Events exposing (keyCode, on, onBlur)
import Json.Decode as Json
import Route exposing (Route)


type Model
    = Loaded


type Msg
    = Navigate Route
    | Unfocus


init : Model
init =
    Loaded


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model, Route.newUrl route )

        Unfocus ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Home page" ]
        , input
            [ type_ "text"
            , placeholder "Please focus and press enter key"
            , onEnter (Navigate Route.Join)
            , onBlur Unfocus
            , style [ ( "width", "180px" ) ]
            ]
            []
        ]


{-| When the enter key is released, send the `msg`.
Otherwise, do nothing.
-}
onEnter : msg -> Attribute msg
onEnter onEnterAction =
    on "keyup" <|
        Json.andThen
            (\keyCode ->
                if keyCode == 13 then
                    Json.succeed onEnterAction
                else
                    Json.fail (toString keyCode)
            )
            keyCode
