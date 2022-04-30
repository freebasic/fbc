'' examples/manual/threads/threadsself-handles.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'THREADSELF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadSelf
'' --------

#include "fbthread.bi"

Dim As Any Ptr phandle(1 To 10)
Dim Shared As Any Ptr pmutex

Sub myThread (ByVal p As Any Ptr)
	MutexLock(pmutex)  ' to ensure that ThreadCreate line is completed before accessing the handle value
	Dim As Any Ptr phandle1 = *CPtr(Any Ptr Ptr, p)
	MutexUnlock(pmutex)
	Dim As Any Ptr phandle2 = ThreadSelf()
	Print Left("   ThreadCreate: " & phandle1 & Space(18), 36) _
		  & "   ThreadSelf: " & phandle2  ' single print with concatenated string avoids using a mutex
	Sleep 100, 1
End Sub

Print "Handles returned from:"
pmutex = MutexCreate()
For I As Integer = 1 To 10
	MutexLock(pmutex)  ' to ensure that ThreadCreate line is completed before thread accesses the handle value
	phandle(I) = ThreadCreate(@myThread, @phandle(I))
	MutexUnlock(pmutex)
Next I

For I As Integer = 1 To 10
	ThreadWait(phandle(I))
Next I
MutexDestroy(pmutex)

Sleep
	
