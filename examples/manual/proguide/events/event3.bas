'' examples/manual/proguide/events/event3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Event Handling'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEventHandling
'' --------

' Memorization in (.mx, .my) of the cursor position of the mouse:
'     - at MOUSE_MOVE event : e.mx = e.x, e.my = e.y
' Memorization in .mbutton of the buttons state of the mouse:
'     - at MOUSE_BUTTON_PRESS event and MOUSE_DOUBLE_CLICK event : e.mbutton = e.mbutton Or e.button
'     - at MOUSE_BUTTON_RELEASE event : e.mbutton = e.mbutton Xor e.button

#include Once "fbgfx.bi"
Using FB

Type EVENTstore Extends Event
	mx As Long
	my As Long
	mbutton As Long
End Type

Screen 19
Dim e As EVENTstore
Do
	If ScreenEvent(@e) Then
		Select Case As Const e.Type
		Case EVENT_MOUSE_MOVE
			e.mx = e.x
			e.my = e.y
			Print Using "Mouse move:                  x=####   /   y=####      dx=####  /  dy=####      button=##";_ 
			e.x; e.y; e.dx; e.dy; e.mbutton
		Case EVENT_MOUSE_BUTTON_PRESS
			e.mbutton = e.mbutton Or e.button
			Print Using "Mouse button press:          button =##               x=####   /   y=####";_ 
			e.button; e.mx; e.my
		Case EVENT_MOUSE_BUTTON_RELEASE
			e.mbutton = e.mbutton Xor e.button
			Print Using "Mouse button release:        button =##               x=####   /   y=####";_ 
			e.button; e.mx; e.my
		Case EVENT_MOUSE_DOUBLE_CLICK
			e.mbutton = e.mbutton Or e.button
			Print Using "Mouse button double click:   button =##               x=####   /   y=####";_ 
			e.button; e.mx; e.my
		Case EVENT_MOUSE_WHEEL
			Print Using "Mouse wheel:                 wheel=  ###########      x=####   /   y=####";_ 
			e.z; e.mx; e.my
		Case EVENT_MOUSE_HWHEEL
			Print Using "Mouse hwheel:                hwheel= ###########      x=####   /   y=####";_ 
			e.z; e.mx; e.my
		Case EVENT_WINDOW_CLOSE
			Exit Do
		End Select
	End If
	Sleep 10, 1
Loop
		
