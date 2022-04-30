'' examples/manual/input/multikey.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MULTIKEY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMultikey
'' --------

#include "fbgfx.bi"
#if __FB_LANG__ = "fb"
Using FB '' Scan code constants are stored in the FB namespace in lang FB
#endif

Dim As Integer x, y

ScreenRes 640, 480

Color 2, 15

x = 320: y = 240
Do
	' Check arrow keys and update the (x, y) position accordingly
	If MultiKey(SC_LEFT ) And x >   0 Then x = x - 1
	If MultiKey(SC_RIGHT) And x < 639 Then x = x + 1
	If MultiKey(SC_UP   ) And y >   0 Then y = y - 1
	If MultiKey(SC_DOWN ) And y < 479 Then y = y + 1
	
	' Lock the page while we work on it
	ScreenLock
		' Clear the screen and draw a circle at the position (x, y)
		Cls
		Circle(x, y), 30, , , , ,F
	ScreenUnlock
	
	Sleep 15, 1
	
	' Run loop until user presses Escape
Loop Until MultiKey(SC_ESCAPE)

' Clear Inkey buffer
While Inkey <> "": Wend


Print "Press CTRL and H to exit..."

Do
	Sleep 25
	
	'' Stay in loop until user holds down CTRL and H at the same time
	If MultiKey(SC_CONTROL) And MultiKey(SC_H) Then Exit Do
Loop
	
