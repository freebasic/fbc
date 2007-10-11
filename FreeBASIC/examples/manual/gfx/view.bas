'' examples/manual/gfx/view.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgViewgraphics
'' --------

Screen 12
Dim ip As Integer Ptr
Dim As Integer i, j, k
'simple sprite
For i=0 To 63: For j=0 To 63:PSet (i,j), (i\4) Xor (j\4):Next j,i
ip=ImageCreate(64,64)
Get (0,0)-(63,63),ip
Cls
'viewport
Line (215,135)-(425,345),1,bf
View  (220,140)-(420,340)
k=0
'move sprite
Do
  i=100*Sin(k*.02)+50:  j=100* Sin(k*.027)+50
  ScreenSync
  ScreenLock
  Cls 1: Put (i,j),ip ,PSet
  ScreenUnlock
  k=k+1
Loop Until Len(Inkey)
ImageDestroy(ip)

