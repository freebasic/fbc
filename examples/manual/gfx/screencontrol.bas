'' examples/manual/gfx/screencontrol.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENCONTROL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreencontrol
'' --------

'' include fbgfx.bi for some useful definitions
#include "fbgfx.bi"

'' use FB namespace for easy access to types/constants
Using FB

Dim e As Event
Dim As Long x0, y0, x, y
Dim As Integer shakes = 0
Dim As Any Ptr img

ScreenRes 320, 200, 32
Print "Click to shake window"

'' find window coordinates
ScreenControl GET_WINDOW_POS, x0, y0

Do

	If (shakes > 0) Then
		
		'' do a shake of the window

		If (shakes > 1) Then

			'' move window to a random position near its original coordinates
			x = x0 + Int(32 * (Rnd() - 0.5))
			y = y0 + Int(32 * (Rnd() - 0.5))
			ScreenControl SET_WINDOW_POS, x, y

		Else

			'' move window back to its original coordinates
			ScreenControl SET_WINDOW_POS, x0, y0

		End If

		shakes -= 1

	End If

	If (ScreenEvent(@e)) Then
		Select Case e.type
		
		'' user pressed the mouse button
		Case EVENT_MOUSE_BUTTON_PRESS

			If (shakes = 0) Then
				'' set to do 20 shakes
				shakes = 20

				'' find current window coordinates to shake around
				ScreenControl GET_WINDOW_POS, x0, y0
			End If

		'' user closed the window or pressed a key
		Case EVENT_WINDOW_CLOSE, EVENT_KEY_PRESS
			'' exit to end of program
			Exit Do

		End Select
	End If

	'' free up CPU for other programs
	Sleep 5

Loop
	
