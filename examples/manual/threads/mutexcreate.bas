'' examples/manual/threads/mutexcreate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MUTEXCREATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexCreate
'' --------

'Visual example of mutual exclusion between 2 threads by using Mutex:
'the "user-defined thread" computes the points coordinates on a circle,
'and the "main thread" plots the points.
'
'Principle of mutual exclusion
'          Thread#A                XOR                  Thread#B
'.....                                         .....
'MutexLock(mut)                                MutexLock(mut)
'  Do_something#A_with_exclusion                 Do_something#B_with_exclusion
'MutexUnlock(mut)                              MutexUnlock(mut)
'.....                                         .....
'
'Behavior:
'- The first point must be pre-calculated.
'- Nothing prevents that a same calculated point could be plotted several times
'(depends on execution times of the loops between main thread and user thread).
'- Nothing prevents that a calculated point could be not plotted
'(same remark on the loop times).
'
'If you comment out the lines containing "MutexLock" and "MutexUnlock"
'(inside "user-defined thread" or/and "main thread"),
'there will be no longer mutual exclusion between computation of coordinates and plotting of points,
'and many points will not be plotted on circle (due to non coherent coordinates).

'-----------------------------------------------------------------------------------------------------

Type ThreadUDT                                   'Generic user thread UDT
	Dim handle As Any Ptr                        'Any Ptr handle to user thread
	Dim sync As Any Ptr                          'Any Ptr handle to mutex
	Dim quit As Byte                             'Boolean to end user thread
	Declare Static Sub Thread (ByVal As Any Ptr) 'Generic user thread procedure
	Dim procedure As Sub (ByVal As Any Ptr)      'Procedure(Any Ptr) to be executed by user thread
	Dim p As Any Ptr                             'Any Ptr to pass to procedure executed by user thread
	Const False As Byte = 0                      'Constante "false"
	Const True As Byte = Not False               'Constante "true"
End Type

Static Sub ThreadUDT.Thread (ByVal param As Any Ptr) 'Generic user thread procedure
	Dim tp As ThreadUDT Ptr = param                  'Casting to generic user thread UDT
	Do
		Static As Integer I
		MutexLock(tp->sync)                          'Mutex (Lock) for user thread
		tp->procedure(tp->p)                         'Procedure(Any Ptr) to be executed by user thread
		I += 1
		Locate 30, 38
		Print I;
		MutexUnlock(tp->sync)                        'Mutex (Unlock) for user thread
		Sleep 5, 1
	Loop Until tp->quit = tp->True                   'Test for ending user thread
End Sub

'-----------------------------------------------------------------------------------------------------

Type Point2D
	Dim x As Integer
	Dim y As Integer
End Type

Const x0 As Integer = 640 / 2
Const y0 As Integer = 480 / 2
Const r0 As Integer = 200
Const pi As Single = 4 * Atn(1)

Sub PointOnCircle (ByVal p As Any Ptr)
	Dim pp As Point2D Ptr = p
	Dim teta As Single = 2 * pi * Rnd
	pp->x = x0 + r0 * Cos(teta)
	Sleep 5, 1                         'To increase possibility of uncorrelated data occurrence
	pp->y = y0 + r0 * Sin(teta)
End Sub


Screen 12
Locate 30, 2
Print "<any_key> : exit";
Locate 30, 27
Print "calculated:";
Locate 30, 54
Print "plotted:";

Dim Pptr As Point2D Ptr = New Point2D
PointOnCircle(Pptr)                   ' Computation for a first point valid on the circle

Dim Tptr As ThreadUDT Ptr = New ThreadUDT
Tptr->sync = MutexCreate
Tptr->procedure = @PointOnCircle
Tptr->p = Pptr
Tptr->handle = ThreadCreate(@ThreadUDT.Thread, Tptr)

Do
	Static As Integer I
	Sleep 5, 1
	MutexLock(Tptr->sync)   'Mutex (Lock) for main thread
	PSet (Pptr->x, Pptr->y) 'Plotting one point
	I += 1
	Locate 30, 62
	Print I;
	MutexUnlock(Tptr->sync) 'Mutex (Unlock) for main thread
Loop Until Inkey <> ""
 
Tptr->quit = Tptr->True
ThreadWait(Tptr->handle)
MutexDestroy(Tptr->sync)
Delete Tptr
Delete Pptr

Sleep
