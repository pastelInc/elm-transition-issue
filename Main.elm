module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Navigation
import Page.Home as Home
import Page.Join as Join
import Route exposing (Route)


type Model
    = LoadedHome Home.Model
    | LoadedJoin Join.Model


type Msg
    = HomeUpdate Home.Msg
    | JoinUpdate Join.Msg
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeUpdate msg ->
            case model of
                LoadedHome home ->
                    let
                        ( subModel, subCmd ) =
                            Home.update msg home
                    in
                    ( LoadedHome subModel, Cmd.map HomeUpdate subCmd )

                _ ->
                    ( model, Cmd.none )

        JoinUpdate msg ->
            case model of
                LoadedJoin join ->
                    let
                        ( subModel, subCmd ) =
                            Join.update msg join
                    in
                    ( LoadedJoin subModel, Cmd.map JoinUpdate subCmd )

                _ ->
                    ( model, Cmd.none )

        UrlChange location ->
            case Debug.log "Transition to" (Route.fromLocation location) of
                Route.Home ->
                    ( LoadedHome Home.init, Cmd.none )

                Route.Join ->
                    ( LoadedJoin Join.init, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        LoadedHome home ->
            Html.map HomeUpdate (Home.view home)

        LoadedJoin join ->
            Html.map JoinUpdate (Join.view join)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    case Route.fromLocation location of
        Route.Home ->
            ( LoadedHome Home.init, Cmd.none )

        Route.Join ->
            ( LoadedJoin Join.init, Cmd.none )


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
