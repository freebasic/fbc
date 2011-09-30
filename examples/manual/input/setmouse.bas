'' examples/manual/input/setmouse.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetmouse
'' --------

Dim As Integer x, y, buttons

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

	' run loop until Escape is pressed
Loop Until Inkey = Chr(27)
