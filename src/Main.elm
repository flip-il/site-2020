module Main exposing (main)

import Browser exposing (Document, UrlRequest, document)
import Colors
import Element as El exposing (Element, alignBottom, alignRight, centerX, centerY, column, el, fill, height, htmlAttribute, layout, link, maximum, minimum, moveDown, padding, paddingEach, paragraph, px, row, spacing, text, textColumn, width)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Element.Region
import Html exposing (Html)
import Html.Attributes
import Http
import Typography exposing (callForActionAnd)
import Url exposing (Protocol(..), Url)
import Url.Builder as UrlBuilder
import Validate exposing (validate)


main =
    document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Flags =
    {}


type EmailForm
    = Empty
    | Invalid String
    | Valid String
    | Sending
    | Success
    | Error Http.Error


type alias Model =
    { emailForm : EmailForm
    }


type Msg
    = OnLoad
    | UrlRequested
    | UrlChange
    | EmailChanged String
    | SaveEmail
    | GotSubscribeResponse (Result Http.Error String)
    | CantSaveEmail


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { emailForm = Empty }, Cmd.none )


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
            ( { model | emailForm = validateEmail newValue }, Cmd.none )

        SaveEmail ->
            ( { model | emailForm = Sending }, subscribe model.emailForm )

        GotSubscribeResponse result ->
            case result of
                Ok response ->
                    ( Debug.log ("Response was: " ++ response) { model | emailForm = Success }, Cmd.none )

                Err error ->
                    ( { model | emailForm = Error error }, Cmd.none )

        CantSaveEmail ->
            ( model, Cmd.none )


validateEmail : String -> EmailForm
validateEmail string =
    let
        isBlankEmail : Validate.Validator EmailForm String
        isBlankEmail =
            Validate.ifBlank (\x -> x) Empty

        isValidEmail : Validate.Validator EmailForm String
        isValidEmail =
            Validate.ifInvalidEmail (\x -> x) (\_ -> Invalid string)
    in
    case validate (Validate.firstError [ isBlankEmail, isValidEmail ]) string of
        Ok result ->
            Valid <| Validate.fromValid result

        Err invalidForm ->
            Maybe.withDefault (Invalid string) <| List.head invalidForm


subscribe : EmailForm -> Cmd Msg
subscribe emailForm =
    case emailForm of
        Valid email ->
            let
                expect =
                    Http.expectString GotSubscribeResponse

                url =
                    UrlBuilder.crossOrigin "https://publ.maillist-manage.com"
                        [ "weboptin.zc" ]
                        [ UrlBuilder.string "CONTACT_EMAIL" email
                        , UrlBuilder.string "SIGNUP_SUBMIT_BUTTON" "Join Now"
                        , UrlBuilder.string "zc_trackCode" "ZCFORMVIEW"
                        , UrlBuilder.string "submitType" "optinCustomView"
                        , UrlBuilder.string "lD" "180bf938f0c3336e"
                        , UrlBuilder.string "formType" "QuickForm"
                        , UrlBuilder.string "zx" "1278bad58"
                        , UrlBuilder.string "zcvers" "3.0"
                        , UrlBuilder.string "mode" "OptinCreateView"
                        , UrlBuilder.string "zcld" "180bf938f0c3336e"
                        , UrlBuilder.string "zc_formIx" "926da915a1a8ef8109f9d9dca07b52fa5ac3649c3e8127e6"
                        , UrlBuilder.string "lf" "1566821542302"
                        , UrlBuilder.string "di" "114688221023179315891566821542308"
                        , UrlBuilder.string "responseMode" "inline"
                        ]
            in
            Http.post
                { url = url
                , body = Http.emptyBody
                , expect = expect
                }

        _ ->
            Cmd.none


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
            el [ width fill, height fill, Background.color Colors.darkText, El.alpha 0.56 ] El.none
    in
    [ layout [ class "backgroundImage" ] <|
        column
            [ width fill
            , height fill
            , centerX
            , centerY
            , padding 24
            , El.behindContent <| imageFromClass "buildingsAll" [ width fill, height fill ]
            , El.behindContent <| backgroundBackdrop
            ]
            [ topBar
            , column [ width fill, centerX, spacing 64 ]
                [ title
                , info model.emailForm
                ]
            , footer
            ]
    ]


class : String -> El.Attribute msg
class name =
    htmlAttribute <| Html.Attributes.class name


imageFromClass : String -> List (El.Attribute msg) -> Element msg
imageFromClass className attrs =
    el (class className :: attrs) El.none


topBar =
    let
        iconDimensions =
            [ width <| px 28, height <| px 28 ]
    in
    row [ width fill, El.spaceEvenly, spacing 24, paddingEach { top = 22, left = 24, right = 24, bottom = 12 } ]
        [ imageFromClass "logo" [ width <| px 127 ]
        , link (callForActionAnd [ alignRight ]) { url = "https://2018.flip-il.org/", label = text "FLIP 2018" }
        , link [] { url = "mailto:info@flip-il.org", label = imageFromClass "mail" iconDimensions }
        , link [] { url = "https://www.facebook.com/FLIPcon/", label = imageFromClass "facebook" iconDimensions }
        , link [] { url = "https://twitter.com/flipcon", label = imageFromClass "twitter" iconDimensions }
        , link [] { url = "https://www.linkedin.com/company/flip-conference/", label = imageFromClass "linkedin" iconDimensions }
        ]


title =
    textColumn [ centerX, spacing 30, width fill ]
        [ paragraph (Typography.titleAnd [ Element.Region.heading 1 ])
            [ text "FLIP 2020 CONFERENCE"
            ]
        , paragraph (Typography.titleAnd [ Element.Region.heading 2 ])
            [ text "COMING SOON"
            ]
        ]


info emailForm =
    let
        boxShadow =
            Border.shadow { offset = ( 4.0, 4.0 ), size = 2.0, blur = 0.0, color = Colors.shadow }

        box =
            column
                [ Background.color Colors.transparentWhite
                , boxShadow
                , centerX
                , paddingEach { top = 20, bottom = 40, left = 25, right = 25 }
                , spacing 36
                , height <| minimum 169 <| El.shrink
                , width <| minimum 761 <| El.shrink
                , Element.Region.mainContent
                ]

        emailField email isValid =
            Input.email
                ([ width <| px 430
                 , boxShadow
                 , Border.rounded 0
                 , Border.widthEach { top = 0, bottom = 2, left = 0, right = 0 }
                 ]
                    ++ (if isValid then
                            []

                        else
                            [ Border.color Colors.errorRed ]
                       )
                )
                { onChange = EmailChanged
                , text = email
                , placeholder = Just <| Input.placeholder [] <| text "your email"
                , label = Input.labelHidden "your email address"
                }

        submitButton isActive =
            Input.button
                [ paddingEach { left = 32, right = 32, top = 8, bottom = 8 }
                , if isActive then
                    Background.color Colors.lightGold

                  else
                    Background.color Colors.grey
                , boxShadow
                , height <| px 40
                ]
                { onPress =
                    if isActive then
                        Just SaveEmail

                    else
                        Just CantSaveEmail
                , label = el Typography.action <| text "Take My Email!"
                }
    in
    case emailForm of
        Empty ->
            box
                [ el (Typography.infoTitleAnd [ centerX ]) <| text "Do you want to be the first to know?"
                , row [ spacing 22 ]
                    [ emailField "" True
                    , submitButton False
                    ]
                ]

        Invalid email ->
            box
                [ el (Typography.infoTitleAnd [ centerX ]) <| text "Do you want to be the first to know?"
                , row [ spacing 22 ]
                    [ emailField email False
                    , submitButton False
                    ]
                ]

        Valid email ->
            box
                [ el (Typography.infoTitleAnd [ centerX ]) <| text "Do you want to be the first to know?"
                , row [ spacing 22 ]
                    [ emailField email True
                    , submitButton True
                    ]
                ]

        Sending ->
            box
                [ el (Typography.infoTitleAnd [ centerX, centerY, Element.Region.announce ]) <|
                    text "Sending"
                ]

        Success ->
            box
                [ el (Typography.infoTitleAnd [ centerX, centerY, Element.Region.announce ]) <|
                    text "Thank you! Confirmation email was sent to your address!"
                ]

        Error e ->
            box
                [ el (Typography.infoTitleAnd [ centerX, centerY, Element.Region.announce ]) <|
                    text "Whoops! Something didn't work..."
                ]


footer =
    row
        ([ width fill, alignBottom, centerX, spacing 12, Element.Region.footer ] ++ Typography.primary)
        [ el Typography.copyright <| text "© All rights reserve to FLIP 2019"
        , El.image [ El.alignRight ] { src = "/microsoft.png", description = "Microsoft logo" }
        , El.image [ El.alignRight ] { src = "/hamakor.png", description = "HaMakor logo - עמותת המקור" }
        ]
