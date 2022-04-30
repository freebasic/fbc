'' examples/manual/proguide/multithreading/criticalsectionfaq9-3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Dim Shared As Any Ptr mutex

Sub Thread (ByVal p As Any Ptr)
	MutexLock(mutex)
	Dim As ULong c0 = Color(Cast(Integer, p) + 8, Cast(Integer, p))
	Dim As ULong c = Color()
	Color(LoWord(c0), HiWord(c0))
	MutexUnlock(mutex)
	For I As Integer = 1 To 50 - 2 * Cast(Integer, p)
		MutexLock(mutex)
		c0 = Color(LoWord(c), HiWord(c))
		Print " " & Cast(Integer, p) & " ";
		Color(LoWord(c0), HiWord(c0))
		MutexUnlock(mutex)
		Sleep 20 * Cast(Integer, p), 1
	Next I
End Sub

Sub test ()
	Dim As Any Ptr p(1 To 9)
	Locate 1, 1
	For I As Integer = 1 To 9
		p(I) = ThreadCreate(@Thread, Cast(Any Ptr, I))
		Sleep 25, 1
	Next I
	For I As Integer = 1 To 9
		ThreadWait(p(I))
	Next I
	Locate 16, 1
End Sub

mutex = MutexCreate

Screen 0
test()
Print "Any key to continue"
Sleep

Screen 12
test()
Print "Any key to quit"
Sleep

MutexDestroy(mutex)
					
