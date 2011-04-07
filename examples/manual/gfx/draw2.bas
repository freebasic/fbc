'' examples/manual/gfx/draw2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDraw
'' --------

Dim As String fill, angle, pattern
Dim As Integer i, a, c

pattern = ("X" & VarPtr(angle)) _
	    & "C15" _
	      "M+100,+10" _
	      "M +15,-10" _
	      "M -15,-10" _
	      "M-100,+10" _
	    & "BM+100,0" & ("X" & VarPtr(fill)) & "BM-100,0"


ScreenRes 320, 240, 8

Draw "BM 160, 120"
a = 0: c = 32
For i = 1 To 24
	
	angle = "TA" & a
	fill = "P" & c & ",15"
	a += 15: c += 1
	
	Draw pattern
	Sleep 100
	
Next i

Sleep
