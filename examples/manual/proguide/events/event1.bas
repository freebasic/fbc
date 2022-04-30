'' examples/manual/proguide/events/event1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Event Handling'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEventHandling
'' --------

'   The main code tests events in a loop:
'       - calls a user Sub each time a key-pressed event is retrieved
'       - exits the loop if a window-close event is retrieved (by click on window-close button)
'   The user Sub prints the character of the key pressed, the ascci code and the scancode.

#include Once "fbgfx.bi"
Using FB

'' user callback Sub definition
Sub printInkeyData (ByVal ascii As Long, ByVal scancode As Long)
	Print "'" & Chr(ascii) & "' (" & ascii & ")", scancode
End Sub

'' user main code
Screen 12
Dim e As Event
Do
	If (ScreenEvent(@e)) Then
		Select Case As Const e.type
		Case EVENT_KEY_PRESS                     '' test key-pressed event
			printInkeyData(e.ascii, e.scancode)
		Case EVENT_WINDOW_CLOSE                  '' test window-close event
			Exit Do
		End Select
	End If
	Sleep 10, 1
Loop
		
