'' examples/manual/proguide/multithreading/criticalsectionfaq8-1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Screen 12

Sub thread(ByVal p As Any Ptr)
	Color 10
	PSet(150, 10)
	For I As Integer = 1 To 40
		Line -Step(10, 10)
		Sleep 150, 1
	Next I
	Draw String Step (-40, 10), "user thread"
End Sub

Dim As Any Ptr p = ThreadCreate(@thread)

Color 14
PSet(10, 100)
For I As Integer = 1 To 24
	Line -Step(10, 10)
	Sleep 250, 1
Next I
Draw String Step (-40, 10), "main thread"

ThreadWait(p)

Color 15
Locate 4, 2
Print "Any key for exit"

Sleep
				
