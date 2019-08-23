module Typography exposing (callForActionAnd, primary, title, titleAnd)

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
    , Font.bold
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
