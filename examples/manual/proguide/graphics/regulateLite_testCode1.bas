'' examples/manual/proguide/graphics/regulateLite_testCode1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Lite regulation function to be integrated into user loop for FPS control'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLiteRegulate
'' --------

#include "regulateLite.bi"

Screen 12
Dim As ULong FPS = 100
Do
	Static As ULongInt l
	ScreenLock
	Cls
	Color 15
	Print Using "Requested FPS : ###"; FPS
	Print
	Print
	Print
	Color 14
	Print "<+>      : Increase FPS"
	Print "<->      : Decrease FPS"
	Print
	Print "<Escape> : Quit"
	Line (0, 32)-(639, 48), 7, B
	Line (0, 32)-(l, 48), 7, BF
	ScreenUnlock
	l = (l + 1) Mod 640
	Dim As String s = Inkey
	Select Case s
	Case "+"
		If FPS < 200 Then FPS += 1
	Case "-"
		If FPS > 10 Then FPS -= 1
	Case Chr(27)
		Exit Do
	End Select
	regulateLite(FPS)
Loop
