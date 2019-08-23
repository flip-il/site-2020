module Main exposing (main)

import Browser exposing (Document, UrlRequest, document)
import Element exposing (Element, alignBottom, alignRight, centerX, centerY, column, el, fill, height, htmlAttribute, layout, link, maximum, minimum, padding, paddingEach, paragraph, px, row, spacing, text, textColumn, width)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes
import Typography exposing (callForActionAnd)
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
    [ layout [ class "backgroundImage" ] <|
        column [ width fill, height fill, centerX, centerY, padding 24 ]
            [ topBar
            , title
            , footer
            ]
    ]


class : String -> Element.Attribute msg
class name =
    htmlAttribute <| Html.Attributes.class name


imageFromClass : String -> List (Element.Attribute msg) -> Element msg
imageFromClass className attrs =
    el (class className :: attrs) Element.none


topBar =
    row [ width fill, Element.spaceEvenly, spacing 24, paddingEach { top = 24, left = 24, right = 24, bottom = 36 } ]
        [ imageFromClass "logo" [ width <| px 127 ]
        , link (callForActionAnd [ alignRight ]) { url = "https://2018.flip-il.org/", label = text "FLIP 2018" }
        , imageFromClass "mail" [ width <| px 28 ]
        , imageFromClass "facebook" [ width <| px 28 ]
        , imageFromClass "twitter" [ width <| px 28 ]
        , imageFromClass "linkedin" [ width <| px 28 ]
        ]


title =
    textColumn [ centerX, spacing 49, width fill ]
        [ paragraph (Typography.titleAnd [])
            [ text "FLIP 2020 CONFERENCE"
            ]
        , paragraph (Typography.titleAnd [])
            [ text "COMING SOON"
            ]
        ]


footer =
    row
        ([ width fill, alignBottom, centerX, spacing 12 ] ++ Typography.primary)
        [ link [ alignRight ] { url = "mailto:info@flip-il.org", label = text "Email us" }
        ]
