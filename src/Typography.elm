module Typography exposing (action, callForActionAnd, copyright, infoTitle, infoTitleAnd, primary, title, titleAnd)

import Colors
import Element exposing (Attribute)
import Element.Font as Font


fontAnd : List (Attribute msg) -> List (Attribute msg) -> List (Attribute msg)
fontAnd font otherAttributes =
    font ++ otherAttributes


primary : List (Attribute msg)
primary =
    [ Font.color Colors.primary
    , Font.size 14
    , Font.family
        [ Font.typeface "Roboto"
        ]
    ]


primaryAnd =
    fontAnd primary


title =
    [ Font.color Colors.primary
    , Font.size 84
    , Font.extraBold
    , Font.italic
    , Font.shadow
        { offset = ( 3, 3 ), blur = 0, color = Colors.titleShadow }
    , Font.wordSpacing 10
    , Font.center
    , Font.family
        [ Font.typeface "Roboto"
        ]
    ]


titleAnd =
    fontAnd title


callForAction =
    [ Font.color Colors.primary
    , Font.bold
    , Font.italic
    , Font.shadow { offset = ( 0, 3 ), blur = 6, color = Colors.shadow }
    ]


callForActionAnd =
    fontAnd callForAction


infoTitle =
    [ Font.family [ Font.typeface "Roboto" ]
    , Font.color Colors.darkText
    , Font.bold
    , Font.italic
    , Font.size 28
    , Font.center
    , Font.letterSpacing 0.84
    , Font.shadow { offset = ( 2, 2 ), blur = 0, color = Colors.shadow }
    ]


infoTitleAnd =
    fontAnd infoTitle


action =
    [ Font.family [ Font.typeface "Roboto" ]
    , Font.color Colors.primary
    , Font.bold
    , Font.italic
    , Font.size 26
    , Font.center
    , Font.shadow { offset = ( 0, 3 ), blur = 6, color = Colors.shadow }
    ]


copyright =
    [ Font.family [ Font.typeface "Roboto" ]
    , Font.color Colors.primary
    , Font.bold
    , Font.italic
    , Font.size 15
    ]
