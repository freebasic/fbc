'' examples/manual/proguide/multithreading/criticalsectionfaq15.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Sub userTask(ByVal p As Any Ptr)   '' task to execute
End Sub

Dim As Double t

'---------------------------------------------------------------------------

Print "Successive (empty) user tasks executed by one thread for each:"
t = Timer
For i As Integer = 1 To 10000
	Dim As Any Ptr p = ThreadCreate(@userTask)
	ThreadWait(p)
Next i
t = Timer - t
Print Using "######.### microdeconds per user task"; t * 100
Print

'---------------------------------------------------------------------------

Type thread
	Public:
		Dim As Sub(ByVal p As Any Ptr) task  '' pointer to user task
		Declare Sub Launch()                 '' launch user task
		Declare Sub Wait()                   '' wait for user task completed
		Declare Constructor()
		Declare Destructor()
	Private:
		Dim As Any Ptr mutex1
		Dim As Any Ptr mutex2
		Dim As Any Ptr handle
		Dim As Boolean quit
		Declare Static Sub proc(ByVal pthread As thread Ptr)
End Type

Constructor thread()
	This.mutex1 = MutexCreate
	This.mutex2 = MutexCreate
	MutexLock(This.mutex1)
	MutexLock(This.mutex2)
	This.handle = ThreadCreate(CPtr(Any Ptr, @thread.proc), @This)
End Constructor

Destructor thread()
	This.quit = True
	MutexUnlock(This.mutex1)
	ThreadWait(This.handle)
	MutexDestroy(This.mutex1)
	MutexDestroy(This.mutex2)
End Destructor

Sub thread.proc(ByVal pthread As thread Ptr)
	Do
		MutexLock(pthread->mutex1)    '' wait for launching task
		If pthread->quit = True Then Exit Sub
		pthread->task(pthread)
		MutexUnlock(pthread->mutex2)  '' task completed
	Loop
End Sub

Sub thread.Launch()
	MutexUnlock(This.mutex1)
End Sub

Sub thread.Wait()
	MutexLock(This.mutex2)
End Sub

Print "Successive (empty) user tasks executed by a single thread for all:"
t = Timer
Dim As thread Ptr pThread = New Thread
pThread->task = @userTask
For i As Integer = 1 To 10000
	pThread->Launch()
	pThread->Wait()
Next i
Delete pThread
t = Timer - t
Print Using "######.### microdeconds per user task"; t * 100
Print

Sleep
