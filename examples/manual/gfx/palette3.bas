'' examples/manual/gfx/palette3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Getting whole palette, form 3.
Dim pal(0 To 255) As Integer
Screen 13
Palette Get Using pal
For i As Integer = 0 To 15
	Print Using "Color ## = &"; i; Hex(pal(i), 6)
Next i
Sleep
