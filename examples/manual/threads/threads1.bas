'' examples/manual/threads/threads1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'THREADCREATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadCreate
'' --------

'' Threading synchronization using Mutexes
'' If you comment out the lines containing "MutexLock" and "MutexUnlock",
'' the threads will not be in sync and some of the data may be printed
'' out of place.

Const MAX_THREADS = 10

Dim Shared As Any Ptr ttylock

'' Teletype unfurls some text across the screen at a given location
Sub teletype( ByRef text As String, ByVal x As Long, ByVal y As Long )
	''
	'' This MutexLock makes simultaneously running threads wait for each
	'' other, so only one at a time can continue and print output.
	'' Otherwise, their Locates would interfere, since there is only one
	'' cursor.
	''
	'' It's impossible to predict the order in which threads will arrive
	'' here and which one will be the first to acquire the lock thus
	'' causing the rest to wait.
	''
	MutexLock ttylock

	For i As Integer = 0 To (Len(text) - 1)
		Locate x, y + i
		Print Chr(text[i])
		Sleep 25, 1
	Next

	'' MutexUnlock releases the lock and lets other threads acquire it.
	MutexUnlock ttylock
End Sub

Sub thread( ByVal userdata As Any Ptr )
	Dim As Integer id = CInt(userdata)
	teletype "Thread (" & id & ").........", 1 + id, 1
End Sub

	'' Create a mutex to syncronize the threads
	ttylock = MutexCreate()

	'' Create child threads
	Dim As Any Ptr handles(0 To MAX_THREADS-1)
	For i As Integer = 0 To MAX_THREADS-1
		handles(i) = ThreadCreate(@thread, CPtr(Any Ptr, i))
		If handles(i) = 0 Then
			Print "Error creating thread:"; i
			Exit For
		End If
	Next

	'' This is the main thread. Now wait until all child threads have finished.
	For i As Integer = 0 To MAX_THREADS-1
		If handles(i) <> 0 Then
			ThreadWait(handles(i))
		End If
	Next

	'' Clean up when finished
	MutexDestroy(ttylock)
