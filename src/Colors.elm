module Colors exposing (background, darkText, errorRed, grey, lightGold, primary, shadow, titleShadow, transparentWhite)

import Element exposing (Color, rgb255, rgba255)


background : Color
background =
    rgb255 44 27 46


primary =
    rgb255 252 233 255


darkText =
    rgb255 44 26 46


titleShadow =
    rgba255 255 179 0 1.0


shadow =
    rgba255 0 0 0 0.16


transparentWhite =
    rgba255 255 255 255 0.63


lightGold =
    rgb255 255 193 7


errorRed =
    rgb255 229 57 53


grey =
    rgb255 192 160 197
