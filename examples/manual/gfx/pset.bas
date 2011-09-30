'' examples/manual/gfx/pset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPset
'' --------

' Set an appropriate Screen mode.
Screen 14

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

' Close the program
End
