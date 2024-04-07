'' examples/manual/threads/condwait.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONDWAIT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondWait
'' --------

' This simple example code demonstrates the use of several condition variable routines.
' The main routine creates three threads.
' Two of the threads update a "count" variable.
' The third thread waits until the count variable reaches a specified value.

#define numThread  3
#define countThreshold 6

Dim Shared As Integer count = 0
Dim Shared As Any Ptr countMutex
Dim Shared As Any Ptr countThresholdCV
Dim As Any Ptr threadID(0 To numThread-1)
Dim Shared As Integer ok = 0

Sub threadCount (ByVal p As Any Ptr)
	Print "Starting threadCount(): thread#" & p
	Do
		Print "threadCount(): thread#" & p & ", locking mutex"
		MutexLock(countMutex)
		count += 1
		' Check the value of count and signal waiting thread when condition is reached.
		' Note that this occurs while mutex is locked.
		If count >= countThreshold Then
			If count = countThreshold Then
				Print "threadCount(): thread#" & p & ", count = " & count & ", threshold reached, unlocking mutex"
				ok = 1
				CondSignal(countThresholdCV)
			Else
				Print "threadCount(): thread#" & p & ", count = " & count & ", threshold exceeded, unlocking mutex"
			End If
			MutexUnlock(countMutex)
			Exit Do
		End If
		Print "threadCount(): thread#" & p & ", count = " & count & ", unlocking mutex"
		MutexUnlock(countMutex)
		Sleep 100, 1
	Loop
End Sub

Sub threadWatch (ByVal p As Any Ptr)
	Print "Starting threadWatch(): thread#" & p & ", locking mutex, waiting for conditional"
	MutexLock(countMutex)
	' Note that the Condwait routine will automatically and atomically unlock mutex while it waits.
	While ok = 0
		CondWait(countThresholdCV, countMutex)
	Wend
	Print "threadWatch(): thread#" & p & ", condition signal received"
	Print "threadWatch(): thread#" & p & ", count now = " & count & ", unlocking mutex"
	MutexUnlock(countMutex)
End Sub

' Create mutex and condition variable
countMutex = MutexCreate
countThresholdCV = CondCreate
' Create threads
threadID(0) = ThreadCreate(@threadWatch, Cast(Any Ptr, 1))
threadID(1) = ThreadCreate(@threadCount, Cast(Any Ptr, 2))
threadID(2) = ThreadCreate(@threadCount, Cast(Any Ptr, 3))
' Wait for all threads to complete
For I As Integer = 0 To numThread-1
	ThreadWait(threadID(I))
	Print "Main(): Waited on thread#" & I+1 & " Done"
Next I
MutexDestroy(countMutex)
CondDestroy(countThresholdCV)
