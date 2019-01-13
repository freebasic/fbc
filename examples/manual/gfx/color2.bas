'' examples/manual/gfx/color2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgColor
'' --------

' In 32-bit color depth, Function Color() returns only the foreground color

#include "fbgfx.bi"

'' screencontrol expects integer/uinteger
Dim As UInteger fgcolor, bkcolor

ScreenRes 500, 500, 32
Width 500\8, 500\16
Color &HFFFF00, &H0000FF
Cls

Print "From Function Color():"
Print "  Foreground Color: "; Hex(Color(), 8)
Print

ScreenControl FB.GET_COLOR, fgcolor, bkcolor
Print "From Sub ScreenControl():"
Print "  Foreground Color: "; Hex(fgcolor, 8)
Print "  Background Color: "; Hex(bkcolor, 8)

Sleep
