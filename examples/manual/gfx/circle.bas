'' examples/manual/gfx/circle.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CIRCLE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCircle
'' --------

' Set 640x480 mode, 256 colors
Screen 18

' Draws a circle in the center
Circle (320, 240), 200, 15

' Draws a filled ellipse
Circle (320, 240), 200, 2, , , 0.2, F

' Draws a small arc
Circle (320, 240), 200, 4, 0.83, 1.67, 3

Sleep
