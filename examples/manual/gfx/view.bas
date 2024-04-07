'' examples/manual/gfx/view.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VIEW (GRAPHICS)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgViewgraphics
'' --------

Screen 12
Dim ip As Any Ptr
Dim As Integer x, y

'simple sprite
ip = ImageCreate(64,64)
For y = 0 To 63
  For x = 0 To 63
	PSet ip, (x, y), (x\4) Xor (y\4)
  Next x
Next y

'viewport with blue border
Line (215,135)-(425,345), 1, bf
View (220,140)-(420,340)

'move sprite around the viewport
Do

  x = 100*Sin(Timer*2.0)+50
  y = 100*Sin(Timer*2.7)+50
  
  ScreenSync
  ScreenLock
  
  'clear viewport and put image
  Cls 1
  Put (x, y), ip, PSet
	
  ScreenUnlock

Loop While Inkey = ""

ImageDestroy(ip)
