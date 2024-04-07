'' examples/manual/gfx/window.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WINDOW'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWindow
'' --------

Screen 13

'' define clipping area
View ( 10, 10 ) - ( 310, 150 ), 1, 15    

'' set view coordinates
Window ( -1, -1 ) - ( 1, 1 )             

'' Draw X axis
Line (-1,0)-(1,0),7
Draw String ( 0.8, -0.1 ), "X"

'' Draw Y axis
Line (0,-1)-(0,1),7
Draw String ( 0.1, 0.8 ), "Y"

Dim As Single x, y, s

'' compute step size (corresponds to a step of 1 pixel on x coordinate)
s = 2 / PMap( 1, 0 )

'' plot the function
For x = -1 To 1 Step s
  y = x ^ 3
  PSet( x, y ), 14
Next x

'' revert to screen coordinates
Window

'' remove the clipping area
View

'' draw title
Draw String ( 120, 160 ), "Y = X ^ 3"

Sleep
