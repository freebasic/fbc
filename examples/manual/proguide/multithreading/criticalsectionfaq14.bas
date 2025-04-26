'' examples/manual/proguide/multithreading/criticalsectionfaq14.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Type ThreadData
	Dim As Integer id
	Dim As Any Ptr mutex
	Dim As Any Ptr cond
	Dim As Boolean flag
	Dim As Boolean quit
	Dim As Any Ptr handle
	Declare Static Sub Thread(ByVal p As Any Ptr)
End Type

Sub ThreadData.Thread(ByVal p As Any Ptr)
	Dim As ThreadData Ptr pdata = p
	Print "   thread #" & pdata->id & " is running"
	Do
		MutexLock(pdata->mutex)
			While pdata->flag = False
				CondWait(pdata->cond, pdata->mutex)
			Wend
			pdata->flag = False
		MutexUnlock(pdata->mutex)
		If pdata->quit = False Then
			Print "   thread #" & pdata->id & " is signaled"
		Else
			Exit Do
		End If
	Loop
	Print "   thread #" & pdata->id & " is finishing"
End Sub


Dim As Any Ptr mutex = MutexCreate()
Dim As Any Ptr cond(0 To 3) = {CondCreate(), CondCreate(), CondCreate(), CondCreate()}
Dim As ThreadData mythreads(1 To 6) = {Type(1, mutex, cond(1)), Type(2, mutex, cond(2)), Type(3, mutex, cond(3)), _
									   Type(4, mutex, cond(0)), Type(5, mutex, cond(0)), Type(6, mutex, cond(0))}

Print "Threads from #1 to #6 are created:"
For I As Integer = LBound(mythreads) To UBound(mythreads)
	mythreads(I).handle = ThreadCreate(@ThreadData.Thread, @mythreads(I))
Next I
Sleep 1000, 1  '' wait for all threads started
Print
Print "----------------------------------------------------------"
Print

For I As Integer = 3 To 1 Step -1
	Print "Send a CondSignal to thread #" & I &":"
	MutexLock(mutex)
		mythreads(I).flag = True
		CondSignal(cond(I))
	MutexUnlock(mutex)
	Sleep 1000, 1  '' wait for the thread loop completed
	Print
Next I
Print "----------------------------------------------------------"
Print

Print "Send a single CondBroadcast to all threads from #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondBroadcast(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for all thread loops completed
Print "Send a single CondBroadcast to all threads from #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondBroadcast(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for all thread loops completed
Print "Send a single CondBroadcast to all threads from #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondBroadcast(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for all thread loops completed
Print
Print "----------------------------------------------------------"
Print

Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print

Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print

Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print "Send a CondSignal to any thread among #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
	Next I
	CondSignal(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for a thread loop completed
Print
Print "----------------------------------------------------------"
Print

For I As Integer = 1 To 3
	Print "Send to finish a CondSignal to thread #" & I &":"
	MutexLock(mutex)
		mythreads(I).flag = True
		mythreads(I).quit = True
		CondSignal(cond(I))
	MutexUnlock(mutex)
	Sleep 1000, 1  '' wait for the thread loop completed
	Print
Next I
Print "----------------------------------------------------------"
Print

Print "Send to finish a single CondBroadcast to all threads from #4 to #6:"
MutexLock(mutex)
	For I As Integer = 4 To 6
		mythreads(I).flag = True
		mythreads(I).quit = True
	Next I
	CondBroadcast(cond(0))
MutexUnlock(mutex)
Sleep 1000, 1  '' wait for all thread loops completed
Print
Print "----------------------------------------------------------"
Print

For I As Integer = 1 To 3
	ThreadWait(mythreads(I).handle)
	CondDestroy(cond(I))
Next I
For I As Integer = 4 To 6
	ThreadWait(mythreads(I).handle)
Next I
Print "All threads from #1 to #6 are finished."
Print

MutexDestroy(mutex)
CondDestroy(cond(0))

Sleep
