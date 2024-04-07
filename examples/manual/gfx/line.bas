'' examples/manual/gfx/line.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LINE (GRAPHICS)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLinegraphics
'' --------

'' draws a diagonal red line with a white box, and waits for 3 seconds
Screen 13
Line (20, 20)-(300, 180), 4
Line (140, 80)-(180, 120), 15, b
Line - ( 200, 200 ), 15
Sleep 3000
