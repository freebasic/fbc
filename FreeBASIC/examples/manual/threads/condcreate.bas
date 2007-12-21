'' examples/manual/threads/condcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondCreate
'' --------

''
'' make newly-created threads wait until all threads are ready, then start them all at once
''

Dim Shared hcondstart As Any Ptr
Dim Shared hmutexstart As Any Ptr
Dim Shared start As Integer = 0

Dim Shared threadcount As Integer
Dim Shared hmutexready As Any Ptr
Dim Shared hcondready As Any Ptr

Sub mythread(ByVal id_ptr As Any Ptr)
	Dim id As Integer = Cast(Integer, id_ptr)

	Print "Thread #" & id & " is waiting..."

	'' signal that this thread is ready
	MutexLock hmutexready
	threadcount += 1
	CondSignal hcondready
	MutexUnlock hmutexready
	
	'' wait for the start signal
	MutexLock hmutexstart
	Do While start = 0	
		CondWait hcondstart, hmutexstart
	Loop

	'' now this thread holds the lock on hmutexstart
	
	MutexUnlock hmutexstart

	'' print out the number of this thread
	For i As Integer = 1 To 40
		Print id;
	Next i
End Sub

Dim threads(1 To 9) As Any Ptr

hcondstart = CondCreate()
hmutexstart = MutexCreate()

hcondready = CondCreate()
hmutexready = MutexCreate()

threadcount = 0


For i As Integer = 1 To 9
	threads(i) = ThreadCreate(@mythread, Cast(Any Ptr, i))
	If threads(i) = 0 Then
		Print "unable to create thread"
	End If
Next i

Print "Waiting until all threads are ready..."

MutexLock(hmutexready)
Do Until threadcount = 9
	CondWait(hcondready, hmutexready)
Loop
MutexUnlock(hmutexready)

Print "Go!"

MutexLock hmutexstart
start = 1
CondBroadcast hcondstart
MutexUnlock hmutexstart

'' wait for all threads to complete
For i As Integer = 1 To 9
	If threads(i) <> 0 Then
		ThreadWait threads(i)
	End If
Next i

MutexDestroy hmutexready
CondDestroy hcondready

MutexDestroy hmutexstart
CondDestroy hcondstart
