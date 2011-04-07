'' examples/manual/gfx/screenset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenset
'' --------

' Set good old 320x200 in 8bpp mode, but with 2 pages
Screen 13, ,2
Color ,15
Dim x As Integer
x = -40
' Let's work on page 1 while we display page 0
ScreenSet 1, 0
Do
	Cls
	Line (x, 80)-(x + 39, 119), 4, BF
	x = x + 1
	If (x > 319) Then x = -40
	' Wait for vertical sync
	Wait &h3DA, 8
	' Copy work page to visible page
	ScreenCopy
Loop While Inkey = ""

