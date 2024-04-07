'' examples/manual/console/locate-getmouse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LOCATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLocate
'' --------

'' Text cursor + mouse tracking
Dim As Long x = 0, y = 0, dx, dy

Cls
Locate , , 1

While Inkey <> Chr(27)
	GetMouse dx, dy
	If( dx <> x Or dy <> y ) Then
		Locate y+1, x+1: Print " ";
		x = dx
		y = dy
		Locate 1, 1: Print x, y, ""
		Locate y+1, x+1: Print "X";
	End If
Wend
