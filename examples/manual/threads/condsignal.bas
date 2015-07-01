'' examples/manual/threads/condsignal.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondSignal
'' --------

' This very simple example code demonstrates the use of several condition variable routines.
' The main routine initializes a string and creates one thread.
' The thread complementes the string, then sends a condition signal.
' The main routine waits until receive the condition signal, then print the complemented string.
'
'Principle of mutual exclusion + simple synchronisation
'          Thread#A                XOR + ==>            Thread#B
'.....                                         .....
'MutexLock(mut)                                MutexLock(mut)
'  Do_something#A_with_exclusion                 While Thread#A_signal <> true
'  Thread#A_signal = true                          CondWait(cond, mut)
'  CondSignal(cond)                              Wend
'MutexUnlock(mut)                                Do_something#B_with_exclusion
'.....                                           Thread#A_signal = false
'                                              MutexUnlock(mut)
'                                              .....

Dim Shared As Any Ptr mutex
Dim Shared As Any Ptr cond
Dim Shared As String txt
Dim As Any Ptr pt
Dim Shared As Integer ok = 0

Sub thread (ByVal p As Any Ptr)
	Print "thread is complementing the string"
	MutexLock(mutex)
	Sleep 400
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
