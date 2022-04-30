'' examples/manual/gfx/draw2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DRAW'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDraw
'' --------

'' Draws a flower on-screen

Dim As Integer i, a, c
Dim As String fill, setangle

'' pattern for each petal
Dim As Const String petal = _
	_
	("X" & VarPtr(setangle)) _ '' link to angle-setting string
	_
	& "C15" _       '' set outline color (white)
	& "M+100,+10" _ '' draw outline
	"M +15,-10" _
	"M -15,-10" _
	"M-100,+10" _
	_
	& "BM+100,0" _              '' move inside petal
	& ("X" & VarPtr(fill)) _    '' flood-fill petal (by linking to fill string)
	& "BM-100,0"                '' move back out



'' set screen
ScreenRes 320, 240, 8

'' move to center
Draw "BM 160, 120"

'' set initial angle and color number
a = 0: c = 32

For i = 1 To 24

	'' make angle-setting and filling command strings
	setangle = "TA" & a
	fill = "P" & c & ",15"

	'' draw the petal pattern, which links to angle-setting and filling strings
	Draw petal
	
	'' short delay
	Sleep 100

	'' increment angle and color number
	a += 15: c += 1

Next i

Sleep
