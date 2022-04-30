'' examples/manual/gfx/color2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COLOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgColor
'' --------

' In 32-bit color depth, Function Color() returns only the foreground color

#include "fbgfx.bi"

'' screencontrol expects integer/uinteger
Dim As Long fgcolor, bkcolor

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
