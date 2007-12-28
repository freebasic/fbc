'' examples/manual/gfx/screencontrol.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreencontrol
'' --------

'' include fbgfx.bi for some useful definitions
#include "fbgfx.bi"

Using fb

Dim e As EVENT
Dim As Integer x, y, pressed, col
Dim As Any Ptr img

ScreenRes 384, 64, 32,, GFX_SHAPED_WINDOW

'' create a fancy window shape
img = ImageCreate(48,8)
Draw String img, (0, 0), "GfxLib"
For y = 0 To 63
	For x = 0 To 383
		col = Point(x \ 8, y \ 8, img)
		If (col <> RGB(255, 0, 255)) Then
			col = RGB((x + y) And &hFF, (x + y) And &hFF, (x + y) And &hFF)
		End If
		PSet (x, y), col
	Next x
Next y

pressed = 0
Do
	If (ScreenEvent(@e)) Then
		Select Case e.type
		Case EVENT_MOUSE_BUTTON_PRESS
			pressed = -1
		Case EVENT_MOUSE_BUTTON_RELEASE
			pressed = 0
		Case EVENT_MOUSE_MOVE
			If (pressed) Then
				ScreenControl GET_WINDOW_POS, x, y
				ScreenControl SET_WINDOW_POS, x + e.dx, y + e.dy
			End If
		End Select
	End If
	Sleep 5
Loop While Not MultiKey(1)
