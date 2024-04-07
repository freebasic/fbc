'' examples/manual/gfx/palette3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PALETTE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Getting whole palette, form 3.
Dim pal(0 To 255) As ULong
Screen 13
Palette Get Using pal
For i As Integer = 0 To 15
	Print Using "Color ## = &"; i; Hex(pal(i), 6)
Next i
Sleep
