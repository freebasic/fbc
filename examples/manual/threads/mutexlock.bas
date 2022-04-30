'' examples/manual/threads/mutexlock.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MUTEXLOCK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexLock
'' --------

'Example of mutual exclusion for synchronization between 2 threads
'by using 2 Mutexes only (by self lock and mutual unlock):
'The Producer works one time, then the Consumer works one time.
'
'Principle of synchronisation by mutual exclusion
'(initial condition: mut#A and mut#B locked)
'
'          Thread#A              XORs              Thread#B
'Do_something#A_with_exclusion          MutexLock(mut#A)
'MutexUnlock(mut#A)                       Do_something#B_with_exclusion
'.....                                  MutexUnlock(mut#B)
'MutexLock(mut#B)                       .....

'----------------------------------------------------------------------

Dim Shared produced As Any Ptr
Dim Shared consumed As Any Ptr
Dim consumer_id As Any Ptr
Dim producer_id As Any Ptr


Sub consumer ( ByVal param As Any Ptr )
	For i As Integer = 0 To 9
		MutexLock produced
		Print , ",consumer gets:" ; i
		MutexUnlock consumed
		Sleep 5, 1
	Next i
End Sub

Sub producer ( ByVal param As Any Ptr )
	For i As Integer = 0 To 9
		Print "Producer puts:" ; i;
		MutexUnlock produced
		MutexLock consumed
	Sleep 5, 1
Next i
End Sub


produced = MutexCreate
consumed = MutexCreate
If ( produced = 0 ) Or ( consumed = 0 ) Then
	Print "Error creating mutexes! Exiting..."
	Sleep
	End
End If

MutexLock produced
MutexLock consumed

consumer_id = ThreadCreate ( @ consumer )
producer_id = ThreadCreate ( @ producer )
If ( producer_id = 0 ) Or ( consumer_id = 0 ) Then
	Print "Error creating threads! Exiting..."
	Sleep
	End
End If

ThreadWait consumer_id
ThreadWait producer_id

MutexDestroy consumed
MutexDestroy produced

Sleep
