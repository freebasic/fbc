'' examples/manual/input/setmouse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SETMOUSE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetmouse
'' --------

Dim As Long x, y, buttons

' create a screen 640*480
ScreenRes 640, 480
Print "Click the mouse button to center the mouse"

Do
	' get mouse x, y and button state (wait until mouse is onscreen)
	Do: Sleep 1: Loop While GetMouse( x, y , , buttons) <> 0

	If buttons And 1 Then
		' on left mouse click, center mouse
		SetMouse 320, 240
	End If

	' run loop until a key is pressed or the window is closed
Loop While Inkey = ""
