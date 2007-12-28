'' examples/manual/gfx/draw.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDraw
'' --------

'' set the screen mode to 320 * 200, 256 color
Screen 13

'' start in the center of the screen
Draw "BM160,100"

'' Draw a box
Draw "U10 R5 D10 L5"
Sleep
