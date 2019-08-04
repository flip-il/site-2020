module Typography exposing (primary, title)

import Colors
import Element exposing (Attribute)
import Element.Font as Font


primary : List (Attribute msg)
primary =
    [ Font.color Colors.primary
    , Font.size 14
    ]


title =
    [ Font.color Colors.primary
    , Font.size 36
    , Font.center
    ]
