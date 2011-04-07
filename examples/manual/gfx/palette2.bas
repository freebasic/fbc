'' examples/manual/gfx/palette2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Getting a single color, form 2.
Dim As Integer r, g, b
Screen 13
Palette Get 32, r, g, b
Print "Color 32 hues:"
Print Using "Red:### Green:### Blue:###"; r; g; b
Sleep
