'' examples/manual/gfx/bload3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBload
'' --------

ScreenRes 640, 480, 8 '' 8-bit palette graphics mode
Dim pal(0 To 256-1) As Integer '' 32-bit integer array with room for 256 colors

'' load bitmap to screen, put palette into pal() array
BLoad "picture.bmp", , @pal(0)

WindowTitle "Old palette"
Sleep

'' set new palette from pal() array
Palette Using pal(0)

WindowTitle "New palette"
Sleep
