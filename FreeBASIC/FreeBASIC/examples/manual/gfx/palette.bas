'' examples/manual/gfx/palette.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPalette
'' --------

' Setting a single color, form 1.
Screen 15
Locate 1,1: Color 15
Print "Press any key to change my color!"
Sleep
' Now change color 15 hues to bright red
Palette 15, &h00003F
Sleep
