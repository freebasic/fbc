'' examples/manual/proguide/graphics/regulateLite_testCode2.bas
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
	Static As ULong MyFPS
	Static As Boolean ImageSkipped
	Static As Long nis
	Static As Long tnis
	If ImageSkipped = False Then
		ScreenLock
		Cls
		Color 15
		Print Using "Requested FPS   : ###"; FPS
		Print
		Color 11
		Print Using "Applied FPS        : ###"; MyFPS
		Print "   Image displayed : 1/" & tnis + 1
		Print
		Print
		Print
		Color 14
		Print "<+>      : Increase FPS"
		Print "<->      : Decrease FPS"
		Print
		Print "<Escape> : Quit"
		Line (0, 80)-(639, 96), 7, B
		Line (0, 80)-(l, 96), 7, BF
		ScreenUnlock
	End If
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
	MyFPS = regulateLite(FPS, , , ImageSkipped)
	If ImageSkipped = True Then
		nis += 1
	Else
		tnis = nis
		nis = 0
	End If
Loop
