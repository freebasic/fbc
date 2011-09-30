'' examples/manual/gfx/palette3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Getting whole palette, form 3.
Dim pal(1 To 256) As Integer
Dim i As Integer
Screen 13
Palette Get Using pal
For i = 1 To 16
	Print "Color"; i; " ="; Hex(pal(i))
Next i
Sleep
