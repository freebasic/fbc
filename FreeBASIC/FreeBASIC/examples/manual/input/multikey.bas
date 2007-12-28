'' examples/manual/input/multikey.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMultikey
'' --------

#include "fbgfx.bi"
Dim work_page As Integer, x As Integer, y As Integer
' Request 640x480 with 2 pages
Screen 18, ,2
Color 2, 15
work_page = 0
x = 320
y = 240
Do
	' Let's work on a page while we display the other one
	ScreenSet work_page, work_page Xor 1
	' Check arrow keys and update position accordingly
	If MultiKey(FB.SC_LEFT) And x > 0 Then x = x - 1
	If MultiKey(FB.SC_RIGHT) And x < 639 Then x = x + 1
	If MultiKey(FB.SC_UP) And y > 0 Then y = y - 1
	If MultiKey(FB.SC_DOWN) And y < 479 Then y = y + 1
	Cls
	Circle(x, y), 30, , , , ,F
	' Page flip
	work_page = work_page Xor 1
Loop While Not MultiKey(FB.SC_ESCAPE)
' Clear input buffer
While Inkey = "": Wend
' Restore both work and visible pages to page 0
ScreenSet
Print "Press CTRL and H to exit..."
Do
Sleep 25
If MultiKey(FB.SC_CONTROL) And MultiKey(FB.SC_H) Then Exit Do
Loop
