module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



--Model


type alias Model =
    { celcInput : String
    , fahrInput : String
    }


init : Model
init =
    { celcInput = ""
    , fahrInput = ""
    }



-- Update


type Msg
    = CelcToFahr String
    | FahrToCelc String


update : Msg -> Model -> Model
update msg model =
    case msg of
        CelcToFahr newInput ->
            { model | celcInput = newInput }

        FahrToCelc newInput ->
            { model | fahrInput = newInput }



-- View


view : Model -> Html Msg
view model =
    div []
        [ case String.toFloat model.celcInput of
            Just celcius ->
                viewConverter model.celcInput "blue" (String.fromFloat (celcius * 1.8 + 32)) "Celcius = " " Fahrenheit" CelcToFahr

            Nothing ->
                viewConverter model.celcInput "red" "???" "Celcius = " " Fahrenheit" CelcToFahr
        , case String.toFloat model.fahrInput of
            Just fahr ->
                viewConverter model.fahrInput "green" (String.fromFloat ((fahr - 32) * 5 / 9)) "Fahrenheit = " " Celcius" FahrToCelc

            Nothing ->
                viewConverter model.fahrInput "orangered" "???" "Fahrenheit = " " Celcius" FahrToCelc
        ]


viewConverter : String -> String -> String -> String -> String -> (String -> Msg) -> Html Msg
viewConverter userInput color equivalentTemp text1 text2 message =
    div []
        [ span []
            [ input [ value userInput, onInput message, style "width" "40px" ] []
            , text text1
            , span [ style "color" color ] [ text equivalentTemp ]
            , text text2
            ]
        ]
