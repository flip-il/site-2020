module Main exposing (main)

import Browser exposing (Document, UrlRequest, document)
import Colors
import Element exposing (Element, alignBottom, alignRight, centerX, centerY, column, el, fill, height, htmlAttribute, layout, link, maximum, minimum, moveDown, padding, paddingEach, paragraph, px, row, spacing, text, textColumn, width)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
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
    { emailForm : String
    }


type Msg
    = OnLoad
    | UrlRequested
    | UrlChange
    | EmailChanged String
    | SaveEmail


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { emailForm = "" }, Cmd.none )


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

        EmailChanged newValue ->
            ( { model | emailForm = newValue }, Cmd.none )

        SaveEmail ->
            Debug.todo "Handle saving an email"


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
    let
        backgroundBackdrop =
            el [ width fill, height fill, Background.color Colors.darkText, Element.alpha 0.56 ] Element.none
    in
    [ layout [ class "backgroundImage" ] <|
        column [ width fill, height fill, centerX, centerY, padding 24, Element.behindContent <| backgroundBackdrop ]
            [ topBar
            , column [ width fill, centerX, spacing 64 ]
                [ title
                , info model.emailForm
                ]
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
    let
        iconDimensions =
            [ width <| px 28, height <| px 28 ]
    in
    row [ width fill, Element.spaceEvenly, spacing 24, paddingEach { top = 22, left = 24, right = 24, bottom = 12 } ]
        [ imageFromClass "logo" [ width <| px 127 ]
        , link (callForActionAnd [ alignRight ]) { url = "https://2018.flip-il.org/", label = text "FLIP 2018" }
        , link [] { url = "mailto:info@flip-il.org", label = imageFromClass "mail" iconDimensions }
        , link [] { url = "https://www.facebook.com/FLIPcon/", label = imageFromClass "facebook" iconDimensions }
        , link [] { url = "https://twitter.com/flipcon", label = imageFromClass "twitter" iconDimensions }
        , link [] { url = "https://www.linkedin.com/company/flip-conference/", label = imageFromClass "linkedin" iconDimensions }
        ]


title =
    textColumn [ centerX, spacing 30, width fill ]
        [ paragraph (Typography.titleAnd [])
            [ text "FLIP 2020 CONFERENCE"
            ]
        , paragraph (Typography.titleAnd [])
            [ text "COMING SOON"
            ]
        ]


info emailForm =
    let
        boxShadow =
            Border.shadow { offset = ( 4.0, 4.0 ), size = 2.0, blur = 0.0, color = Colors.shadow }
    in
    column
        [ Background.color Colors.transparentWhite
        , boxShadow
        , centerX
        , paddingEach { top = 20, bottom = 40, left = 25, right = 25 }
        , spacing 36
        ]
        [ el (Typography.infoTitleAnd [ centerX ]) <| text "Do you want to be the first to know?"
        , row [ spacing 22 ]
            [ Input.email [ width <| px 430, boxShadow, Border.rounded 0 ]
                { onChange = EmailChanged
                , text = emailForm
                , placeholder = Just <| Input.placeholder [] <| text "your email"
                , label = Input.labelHidden "your email address"
                }
            , Input.button
                [ paddingEach { left = 32, right = 32, top = 8, bottom = 8 }
                , Background.color Colors.lightGold
                , boxShadow
                , height <| px 40
                ]
                { onPress = Just SaveEmail, label = el Typography.action <| text "Take My Email!" }
            ]
        ]


footer =
    row
        ([ width fill, alignBottom, centerX, spacing 12 ] ++ Typography.primary)
        []
