module Main exposing (main)

import Browser exposing (Document, UrlRequest, document)
import Browser.Navigation exposing (Key)
import Colors
import Element exposing (alignBottom, alignRight, centerX, centerY, column, fill, height, layout, link, padding, row, spacing, text, width)
import Element.Background as Background
import Framework.Typography exposing (h1)
import Html exposing (Html)
import Typography
import Url exposing (Url)


main =
    document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Flags =
    {}


type alias Model =
    {}


type Msg
    = OnLoad
    | UrlRequested
    | UrlChange


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( {}, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "FLIP 2020"
    , body = body model
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLoad ->
            ( model, Cmd.none )

        UrlRequested ->
            ( model, Cmd.none )

        UrlChange ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


onUrlRequest : UrlRequest -> Msg
onUrlRequest request =
    UrlRequested


onUrlChange : Url -> Msg
onUrlChange url =
    UrlChange


body : Model -> List (Html Msg)
body model =
    [ layout [ Background.color Colors.background ] <|
        column [ width fill, height fill, centerX, centerY, padding 24 ]
            [ title
            , footer
            ]
    ]


title =
    h1 ([ centerX, centerY ] ++ Typography.title) <| text "FLIP 2020 - Coming Soon!"


footer =
    row
        ([ width fill, alignBottom, centerX, spacing 12 ] ++ Typography.primary)
        [ link [ alignRight ] { url = "mailto:info@flip-il.org", label = text "Email us" }
        , link [ alignRight ] { url = "https://2018.flip-il.org/", label = text "FLIP 2018" }
        ]
