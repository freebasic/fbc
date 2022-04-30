'' examples/manual/gfx/pset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPset
'' --------

' Set an appropriate screen mode - 320 x 240 x 8bpp indexed color
ScreenRes 320, 240, 8

' Plot a pixel at the coordinates 100, 100, Color 15. (white)
PSet (100, 100), 15
' Confirm the operation.
Locate 1: Print "Pixel plotted at 100, 100"
' Wait for a keypress.
Sleep
 
' Plot another pixel at the coordinates 150, 150, Color 4. (red) 
PSet (150, 150), 4
' Confirm the operation.
Locate 1: Print "Pixel plotted at 150, 150"
' Wait for a keypress.
Sleep
 
' Plot a third pixel relative to the second, Color 15. (white)
' This pixel is given the coordinates 60, 60. It will be placed
' at 60, 60 plus the previous coordinates (150, 150), thus plotting at 210, 210.
PSet Step (60, 60), 15
' Confirm the operation.
Locate 1: Print "Pixel plotted at 150 + 60, 150 + 60"
' Wait for a keypress
Sleep

' Explicit end of program
End
