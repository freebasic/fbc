'' examples/manual/threads/mutexunlock.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexUnlock
'' --------

'' Threading synchronization using Mutexes
'' If you comment out the lines containing "MutexLock" and "MutexUnlock",
'' the threads will not be in sync and some of the data may be printed
'' out of place.

Declare Sub thread1( param As Any Ptr )
Declare Sub thread2( param As Any Ptr )
Declare Sub teletype (ByVal text As String, ByVal x As Integer, ByVal y As Integer)

Dim Shared threadsync As Any Ptr
Dim Shared thread1handle As Any Ptr
Dim Shared thread2handle As Any Ptr

'' Create a mutex to synchronize the threads
threadsync = MutexCreate

'' Call thread 1
thread1handle = ThreadCreate(@thread1)
If thread1handle = 0 Then
	Print "Error creating thread1"
End If

'' Call thread 2
thread2handle = ThreadCreate(@thread2)
If thread2handle = 0 Then
	Print "Error creating thread1"
End If

'' Wait until both threads are finished
ThreadWait(thread1handle)
ThreadWait(thread2handle)

teletype "Testing.................", 1, 1
teletype "Testing again...........", 10, 1

'' Discard the mutex when we are through using teletype
MutexDestroy threadsync

Sleep
End

'' Thread 1 calls a simple "teletype" routine
Sub thread1( param As Any Ptr )
	teletype "This is a test...", 4, 1
End Sub

'' ...As does thread 2
Sub thread2( param As Any Ptr )
	teletype "This is another test...", 7, 1
End Sub

'' Teletype unfurls some text across the screen at a given location
Sub teletype (ByVal text As String, ByVal x As Integer, ByVal y As Integer)
	Dim i As Integer, a As Integer
	Dim text_length As Integer

	text_length = Len(text)
	For a = 0 To text_length
	    '' MutexLock prevents the two simultaneously running
	    '' threads from sharing "x", "y", and "a"
	    MutexLock threadsync

	    Locate x,(y+a)
	    Print Chr(text[a])

	    '' MutexUnlock releases these variables for other use
	    MutexUnlock threadsync

	    Sleep 25
   Next a
End Sub
