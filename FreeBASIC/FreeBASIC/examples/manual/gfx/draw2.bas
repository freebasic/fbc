'' examples/manual/gfx/draw2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDraw
'' --------

Screen 13
Draw "BM160,100"

'' Draw a box
Dim As String drawbox = "U10R5D10L5"
Draw "X" & VarPtr(drawbox)
Sleep
