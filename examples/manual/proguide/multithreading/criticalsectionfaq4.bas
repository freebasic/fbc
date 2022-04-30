'' examples/manual/proguide/multithreading/criticalsectionfaq4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Dim As Any Ptr handle
Dim Shared As Any Ptr mutex
Dim Shared As Any Ptr cond1
Dim Shared As Any Ptr cond2
Dim Shared As Integer new1
Dim Shared As Integer new2
Dim Shared As Integer quit

Sub Thread (ByVal param As Any Ptr)
	Do
		MutexLock(mutex)
		Print "1";
		new1 = 1
		CondSignal(cond1)
		While new2 <> 1
			CondWait(cond2, mutex)
		Wend
		new2 = 0
		If quit = 1 Then
			MutexUnlock(mutex)
			Exit Do
		End If
		MutexUnlock(mutex)
		Sleep 1, 1
	Loop
End Sub


mutex = MutexCreate
cond1 = CondCreate
cond2 = CondCreate
handle = ThreadCreate(@Thread)

Do
	MutexLock(mutex)
	While new1 <> 1
		CondWait(cond1, mutex)
	Wend
	new1 = 0
	Print "0";
	new2 = 1
	CondSignal(cond2)
	If Inkey <> "" Then
		quit = 1
		MutexUnlock(mutex)
		Exit Do
	End If
	MutexUnlock(mutex)
	Sleep 1, 1
Loop
 
ThreadWait(handle)
MutexDestroy(mutex)
CondDestroy(cond1)
CondDestroy(cond2)
Print

Sleep
					
