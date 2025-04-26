'' examples/manual/proguide/multithreading/criticalsectionfaq13-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Dim Shared As Any Ptr pt, mutex1, mutex2, cond1, cond2
Dim Shared As Integer quit, flag1, flag2

Print "'1': Main thread procedure running (alone)"
Print "'2': Child thread procedure running (alone)"
Print "'-': Main thread procedure running (with the one of child thread)"
Print "'=': Child thread procedure running (with the one of main thread)"
Print

Sub Prnt(ByRef s As String, ByVal n As Integer)
	For I As Integer = 1 To n
		Print s;
		Sleep 20, 1
	Next I
End Sub

Sub ThreadCondCond(ByVal p As Any Ptr)
	Do
		MutexLock(mutex1)
		While flag1 = 0              '' test flag set from main thread
			CondWait(cond1, mutex1)  '' wait for conditional signal from main thread
		Wend
		flag1 = 0                    '' reset flag
		MutexUnlock(mutex1)
		If quit = 1 Then Exit Sub    '' exit the threading loop
		Prnt("=", 10)
		MutexLock(mutex2)
		flag2 = 1                    '' set flag to main thread
		CondSignal(cond2)            '' send conditional signal to main thread
		Prnt("2", 10)
		MutexUnlock(mutex2)
	Loop
End Sub

mutex1 = MutexCreate()
mutex2 = MutexCreate()
cond1 = CondCreate()
cond2 = CondCreate()

pt = ThreadCreate(@ThreadCondCond)
For I As Integer = 1 To 5
	MutexLock(mutex1)
	flag1 = 1                    '' set flag to child thread
	CondSignal(cond1)            '' send conditional signal to child thread
	MutexUnlock(mutex1)
	Prnt("-", 10)
	MutexLock(mutex2)
	While flag2 = 0              '' test flag set from child thread
		CondWait(Cond2, mutex2)  '' wait for conditional signal from child thread
	Wend
	flag2 = 0                    '' reset flag
	Prnt("1", 10)
	MutexUnlock(mutex2)
Next I

MutexLock(mutex1)
quit = 1                         '' set quit for child thread
flag1 = 1
CondSignal(cond1)                '' send conditional signal to child thread
MutexUnlock(mutex1)
ThreadWait(pt)                   '' wait for child thread to end
Print

MutexDestroy(mutex1)
MutexDestroy(mutex2)
CondDestroy(cond1)
CondDestroy(cond2)

Sleep
