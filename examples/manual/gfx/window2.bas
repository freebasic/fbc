'' examples/manual/gfx/window2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WINDOW'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWindow
'' --------

'' The program shows how changing the view coordinates mapping for the current viewport changes the size of a figure drawn on the screen.
'' The effect is one of zooming in and out:
''   - As the viewport coordinates get smaller, the figure appears larger on the screen, until parts of it are finally clipped,
''        because they lie outside the window.
''   - As the viewport coordinates get larger, the figure appears smaller on the screen.

Declare Sub Zoom (ByVal X As Integer)
Dim As Integer X = 500, Xdelta = 50

Screen 12
Do
  Do While X < 525 And X > 50
	X += Xdelta                      '' Change window size.
	Zoom(X)
	If Inkey <> "" Then Exit Do, Do  '' Stop if key pressed.
	Sleep 100
  Loop
  X -= Xdelta
  Xdelta *= -1                       '' Reverse size change.
Loop

Sub Zoom (ByVal X As Integer)
  Window (-X,-X)-(X,X)               '' Define new window.
  ScreenLock
  Cls
  Circle (0,0), 60, 11, , , 0.5, F   '' Draw ellipse with x-radius 60.
  ScreenUnlock
End Sub
