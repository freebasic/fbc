'' examples/manual/proguide/graphics/use_delay.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fine-grain procedure for waiting and in-loop procedure for fine-regulating FPS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDelayRegulate
'' --------

#include "delay_regulate_framerate.bi"

Dim As Double t
Dim As Single t0 = 100

For N As Integer = 1 To 4
	Print "Requested delay :"; t0; " ms"
	For I As Integer = 1 To 4
		t = Timer
		delay(t0)
		Print Using"  Measured delay : ###.### ms"; (Timer - t) * 1000
	Next I
	Print
	t0 /= 10
Next N

Sleep
