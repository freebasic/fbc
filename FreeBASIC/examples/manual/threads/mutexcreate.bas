'' examples/manual/threads/mutexcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexCreate
'' --------

'' Threading syncronyzation using Mutexes
'' If you comment out the lines containing "MutexLock" and "MutexUnlock",
'' the threads will not be in sync and some of the data may be printed
'' out of place.

Const MAX_THREADS = 10

Declare Sub thread( ByVal id_ptr As Any Ptr )
Declare Sub teletype (ByVal text As String, ByVal x As Integer, ByVal y As Integer)

Dim Shared threadsync As Any Ptr

Dim i As Integer

Dim handleTb(0 To MAX_THREADS-1) As Any Ptr

'' Create a mutex to syncronize the threads
threadsync = MutexCreate

'' Create threads
For i = 0 To MAX_THREADS-1
	handleTb(i) = ThreadCreate(@thread, @i)
	If handleTb(i) = 0 Then
		Print "Error creating thread:"; i
		Exit For
	End If
Next

'' Wait until all threads are finished
For i = 0 To MAX_THREADS-1
	If( handleTb(i) <> 0 ) Then
		ThreadWait( handleTb(i) )
	End If
Next

teletype "Testing.................", 1, 1
teletype "Testing again...........", 10, 1

'' Discard the mutex when we are through using teletype
MutexDestroy threadsync

Sub thread( ByVal id_ptr As Any Ptr )
	Dim id As Integer
	id = *Cast( Integer Ptr, id_ptr )
	teletype "Thread (" & id & ").........", 1, 1+id
End Sub

'' Teletype unfurls some text across the screen at a given location
Sub teletype (ByVal text As String, ByVal x As Integer, ByVal y As Integer)
	Dim i As Integer

	For i = 0 To Len(text)-1
	    '' MutexLock prevents the two simultaneously running
	    '' threads from sharing "x", "y", and "a"
	    MutexLock threadsync

	    Locate y, x+i
	    Print Chr(text[i])

	    '' MutexUnlock releases these variables for other use
	    MutexUnlock threadsync

	    Sleep 25
   Next
End Sub
