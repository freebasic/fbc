'' examples/manual/proguide/multithreading/criticalsectionfaq1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

'   - The "user-defined thread" computes the points coordinates on a circle,
'     and write those in a LongInt (32-bit & 32-bit = 64-bit)
'   - The "main thread" plots the points from the LongInt value.
'
'   Behavior:
'      - The first point must be pre-determined.
'      - Nothing prevents that a same calculated point could be plotted several times
'      (depends on execution times of the loops between main thread and user thread).
'      - Nothing prevents that a calculated point could be not plotted
'      (same remark on the loop times).
'
'   Remark:
'      Voluntarily, there is no Sleep in the loop of each thread (normally strongly discouraged),
'      but this is just in this special case to amplify the behavior effects to observe.


Union Point2D
	Dim As LongInt xy
	Type
		Dim As Long y
		Dim As Long x
	End Type
End Union

Dim As Any Ptr handle
Dim Shared As Any Ptr mutex
Dim Shared As Integer quit

Sub Thread (ByVal param As Any Ptr)
	Const pi As Single = 4 * Atn(1)
	Dim As Point2D Ptr p = param
	Do
		Dim As Point2D P2D0
		Dim As Single teta = 2 * pi * Rnd
		P2D0.x = 320 + 200 * Cos(teta)
		P2D0.y = 240 + 200 * Sin(teta)
'        Mutexlock(mutex)
		p->xy = P2D0.xy
'        Mutexunlock(mutex)
'        Sleep 5, 1
	Loop Until quit = 1
End Sub


Screen 12

Dim As Point2D P2D
P2D.x = 520
P2D.y = 240

mutex = MutexCreate
handle = ThreadCreate(@Thread, @P2D)

Dim As Integer c

Do
	Dim As Point2D P2D0
'    Mutexlock(mutex)
	P2D0.xy = P2D.xy
'    Mutexunlock(mutex)
	PSet (P2D0.x, P2D0.y), c
	c = (c Mod 15) + 1
'    Sleep 5, 1
Loop Until Inkey <> ""
 
quit = 1
ThreadWait(handle)
MutexDestroy(mutex)
			
