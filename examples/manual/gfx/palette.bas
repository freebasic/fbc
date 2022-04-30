'' examples/manual/gfx/palette.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PALETTE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Setting a single color, form 1.
Screen 15
Locate 1,1: Color 15
Print "Press any key to change my color!"
Sleep
' Now change color 15 hues to bright red
Palette 15, &h00003F
Sleep
