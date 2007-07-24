'' examples/manual/threads/threadwait.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadWait
'' --------

Dim Shared printsync As Any Ptr

Sub mythread(ByVal idp As Any Ptr)
  Var id = CInt(idp)
  Dim As Double t, w
  Dim As Integer i, n

  If( id = 1 ) Then
	w = 1
	n = 10
  Else
	w = 0.3
	n = 5
  End If

  For i = 1 To n

	MutexLock printsync
	Print "Thread #"; id; ": on step #"; i
	MutexUnlock printsync

	'' simulate some work
	t = Timer
	While( Timer - t ) < w
	Wend

  Next i

  MutexLock printsync
  Print "Thread #"; id; " is done "
  MutexUnlock printsync

End Sub

Dim As Any Ptr t1, t2

Print "Starting threads ... "

'' create a mutex to sync printing
printsync = MutexCreate()

'' create 2 threads, each taking a different
'' amount of time to complete
t1 = ThreadCreate( @mythread, Cast(Any Ptr, 1) )
t2 = ThreadCreate( @mythread, Cast(Any Ptr, 2) )

'' wait for threads to complete
ThreadWait( t1 )
ThreadWait( t2 )

MutexDestroy printsync

Print "All done."
