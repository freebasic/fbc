'' examples/manual/threads/condsignal.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONDSIGNAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondSignal
'' --------

' This very simple example code demonstrates the use of several condition variable routines.
' The main routine initializes a string and creates one thread.
' The main routine waits until receive the condition signal from the thread, then print the complemented string.
' The thread complements the string, then sends a condition signal.
'
'Principle of mutual exclusion + simple synchronization
'          Thread#A             XOR + ==>            Thread#B
'.....                                     .....
'MutexLock(mut)                            MutexLock(mut)
'  Do_something_with_exclusion               Do_something_with_exclusion
'  Thread_signal = true -------------------> While Thread_signal <> true
'  CondSignal(cond) -------------------------> CondWait(cond, mut)
'  Do_something_with_exclusion      .------> Wend
'MutexUnlock(mut) ------------------'        Thread_signal = false
'.....                                       Do_something_with_exclusion
'.....                                     MutexUnlock(mut)
'.....                                     .....


Dim Shared As Any Ptr mutex
Dim Shared As Any Ptr cond
Dim Shared As String txt
Dim As Any Ptr pt
Dim Shared As Integer ok = 0

Sub thread (ByVal p As Any Ptr)
	Print "thread is complementing the string"
	MutexLock(mutex)
	Sleep 400, 1
	txt &= " complemented by thread"
	ok = 1
	CondSignal(cond)
	MutexUnlock(mutex)
	Print "thread signals the processing completed"
End Sub

mutex = MutexCreate
cond = CondCreate

txt = "example of text"
Print "main() initializes a string = " & txt
Print "main creates one thread"
Print
pt = ThreadCreate(@thread)
MutexLock(mutex)
While ok <> 1
	CondWait(cond, mutex)
Wend
Print
Print "back in main(), the string = " & txt
ok = 0
MutexUnlock(mutex)

ThreadWait(pt)
MutexDestroy(mutex)
CondDestroy(cond)
