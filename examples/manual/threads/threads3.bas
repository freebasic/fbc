'' examples/manual/threads/threads3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'THREADCREATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadCreate
'' --------

'' Threaded consumer/producer example using mutexes

Dim Shared As Any Ptr produced, consumed 

Sub consumer( ByVal param As Any Ptr )
	For i As Integer = 0 To 9
		MutexLock produced
		Print ", consumer gets:", i
		Sleep 500, 1
		MutexUnlock consumed
	Next
End Sub

Sub producer( ByVal param As Any Ptr )
	For i As Integer = 0 To 9
		Print "Producer puts:", i;
		Sleep 500, 1
		MutexUnlock produced
		MutexLock consumed
	Next i
End Sub

	Dim As Any Ptr consumer_id, producer_id

	produced = MutexCreate
	consumed = MutexCreate
	If( ( produced = 0 ) Or ( consumed = 0 ) ) Then
		Print "Error creating mutexes! Exiting..."
		End 1
	End If

	MutexLock produced
	MutexLock consumed
	consumer_id = ThreadCreate(@consumer)
	producer_id = ThreadCreate(@producer)
	If( ( producer_id = 0 ) Or ( consumer_id = 0 ) ) Then
		Print "Error creating threads! Exiting..."
		End 1
	End If

	ThreadWait consumer_id
	ThreadWait producer_id

	MutexDestroy consumed
	MutexDestroy produced

	Sleep
