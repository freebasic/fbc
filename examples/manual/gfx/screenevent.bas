'' examples/manual/gfx/screenevent.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENEVENT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenevent
'' --------

'' include fbgfx.bi for some useful definitions
#include "fbgfx.bi"
#if __FB_LANG__ = "fb"
Using fb '' constants and structures are stored in the FB namespace in lang fb
#endif

Dim e As Event

ScreenRes 640, 480
Do
	If (ScreenEvent(@e)) Then
		Select Case e.type
		Case EVENT_KEY_PRESS
			If (e.scancode = SC_ESCAPE) Then
				End
			End If
			If (e.ascii > 0) Then
				Print "'" & e.ascii & "'";
			Else
				Print "unknown key";
			End If
			Print " was pressed (scancode " & e.scancode & ")"
		Case EVENT_KEY_RELEASE
			If (e.ascii > 0) Then
				Print "'" & e.ascii & "'";
			Else
				Print "unknown key";
			End If
			Print " was released (scancode " & e.scancode & ")"
		Case EVENT_KEY_REPEAT
			If (e.ascii > 0) Then
				Print "'" & e.ascii & "'";
			Else
				Print "unknown key";
			End If
			Print " is being repeated (scancode " & e.scancode & ")"
		Case EVENT_MOUSE_MOVE
			Print "mouse moved to " & e.x & "," & e.y & " (delta " & e.dx & "," & e.dy & ")"
		Case EVENT_MOUSE_BUTTON_PRESS
			If (e.button = BUTTON_LEFT) Then
				Print "left";
			ElseIf (e.button = BUTTON_RIGHT) Then
				Print "right";
			Else
				Print "middle";
			End If
			Print " button pressed"
		Case EVENT_MOUSE_BUTTON_RELEASE
			If (e.button = BUTTON_LEFT) Then
				Print "left";
			ElseIf (e.button = BUTTON_RIGHT) Then
				Print "right";
			Else
				Print "middle";
			End If
			Print " button released"
		Case EVENT_MOUSE_DOUBLE_CLICK
			If (e.button = BUTTON_LEFT) Then
				Print "left";
			ElseIf (e.button = BUTTON_RIGHT) Then
				Print "right";
			Else
				Print "middle";
			End If
			Print " button double clicked"
		Case EVENT_MOUSE_WHEEL
			Print "mouse wheel moved to position " & e.z
		Case EVENT_MOUSE_ENTER
			Print "mouse moved into program window"
		Case EVENT_MOUSE_EXIT
			Print "mouse moved out of program window"
		Case EVENT_WINDOW_GOT_FOCUS
			Print "program window got focus"
		Case EVENT_WINDOW_LOST_FOCUS
			Print "program window lost focus"
		Case EVENT_WINDOW_CLOSE
			End
		Case EVENT_MOUSE_HWHEEL
			Print "horizontal mouse wheel moved to position " & e.w
		End Select
	End If

	Sleep 1
Loop
