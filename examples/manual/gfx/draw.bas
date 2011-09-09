'' examples/manual/gfx/draw.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDraw
'' --------

Screen 13

'Move to (50,50) without drawing
Draw "BM 50,50"

'Set drawing color to 2 (green)
Draw "C2"

'Draw a box
Draw "R50 D30 L50 U30"

'Move inside the box
Draw "BM +1,1"

'Flood fill with color 1 (blue) up to border color 2 
Draw "P 1,2"

Sleep
