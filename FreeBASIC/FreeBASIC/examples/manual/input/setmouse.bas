'' examples/manual/input/setmouse.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetmouse
'' --------

#include "fbgfx.bi"
Dim x As Integer, y As Integer, buttons As Integer

' create a screen 800x600, 32-bit color, 1 video page
Screen 19, 32, 1                         

Do
	' get mouse x, y and button state
	GetMouse x, y , , buttons                     

	If buttons = 1 Then
	    ' on left mouse click, center mouse
	    SetMouse 400, 300
	End If

	' do loop until esc is pressed
Loop Until MultiKey(fb.SC_ESCAPE)                             
