'' examples/manual/proguide/graphics/use_regulate_framerate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fine-grain procedure for waiting and in-loop procedure for fine-regulating FPS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDelayRegulate
'' --------

#include "delay_regulate_framerate.bi"

Screen 12
Dim As ULong FPS = 60
Do
	Static As ULongInt l
	Static As Single dt
	ScreenLock
	Cls
	Color 11
	Print Using "Requested FPS : ###"; FPS
	Print
	Print Using "Applied delay : ###.### ms"; dt
	Print Using "Measured FPS  : ###"; framerate()
	Print
	Print
	Print
	Color 14
	Print "<+>      : Increase FPS"
	Print "<->      : Decrease FPS"
	Print "<Escape> : Quit"
	Line (0, 80)-(639, 96), 7, B
	Line (0, 80)-(l, 96), 7, BF
	ScreenUnlock
	l = (l + 1) Mod 640
	Dim As String s = Inkey
	Select Case s
	Case "+"
		If FPS < 100 Then FPS += 1
	Case "-"
		If FPS > 10 Then FPS -= 1
	Case Chr(27)
		Exit Do
	End Select
	dt = regulate(FPS)
Loop
