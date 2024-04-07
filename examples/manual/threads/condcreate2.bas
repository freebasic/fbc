'' examples/manual/threads/condcreate2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONDCREATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondCreate
'' --------

'Visual example of mutual exclusion + mutual synchronization between 2 threads
'by using Mutex and CondVar:
'the "user-defined thread" computes the points coordinates on a circle,
'and the "main thread" plots the points.
'
'Principle of mutual exclusion + mutual synchronisation
'          Thread#A               XOR + <==>             Thread#B
'.....                                          .....
'MutexLock(mut)                                 MutexLock(mut)
'  Do_something_with_exclusion                    Do_something_with_exclusion
'  While bool#1 <> true <------------------------ bool#1 = true
'    CondWait(cond#1, mut) <--------------------- CondSignal(cond#1)
'  Wend <-----------------------------------.     Do_something_with_exclusion
'  bool#1 = false               .---------- | --> While bool#2 <> true
'  Do_something_with_exclusion  |   .------ | ----> CondWait(cond#2, mut)
'  bool#2 = true ---------------'   |   .-- | --> Wend
'  CondSignal(cond#2) --------------'   |   |     bool#2 = false
'  Do_something_with_exclusion          |   |     Do_something_with_exclusion
'MutexUnlock(mut) ----------------------'   '-- MutexUnlock(mut)
'.....                                          .....
'
'Behavior:
'- Unnecessary to pre-calculate the first point.
'- Each calculated point is plotted one time only.
'
'If you comment out the lines containing "MutexLock" and "MutexUnlock",
'"CondWait" and "CondSignal", ".ready"
'(inside "user-defined thread" or/and "main thread"),
'there will be no longer mutual exclusion nor mutual synchronization
'between computation of coordinates and plotting of points,
'and many points will not be plotted on circle (due to non coherent coordinates).

'-----------------------------------------------------------------------------------------------------

Type ThreadUDT                                   'Generic user thread UDT
	Dim handle As Any Ptr                        'Any Ptr handle to user thread
	Dim sync As Any Ptr                          'Any Ptr handle to mutex
	Dim cond1 As Any Ptr                         'Any Ptr handle to conditional1
	Dim cond2 As Any Ptr                         'Any Ptr handle to conditional2
	Dim ready1 As Byte                           'Boolean to coordinates ready1
	Dim ready2 As Byte                           'Boolean to coordinates ready2
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
		tp->ready1 = True                            'Set ready1
		CondSignal(tp->cond1)                        'CondSignal to send signal1 to main thread
		While tp->ready2 <> True                     'Process loop against spurious wakeups
			CondWait(tp->cond2, tp->sync)            'CondWait to receive signal2 from main-thread
		Wend
		tp->ready2 = False
		If tp->quit = tp->True Then                  'Test for ending user thread
			MutexUnlock(tp->sync)                    'Mutex (Unlock) for user thread
			Exit Do
		End If
		MutexUnlock(tp->sync)                        'Mutex (Unlock) for user thread
		Sleep 5, 1
	Loop
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

Dim Tptr As ThreadUDT Ptr = New ThreadUDT
Tptr->sync = MutexCreate
Tptr->cond1 = CondCreate
Tptr->cond2 = CondCreate
Tptr->procedure = @PointOnCircle
Tptr->p = Pptr
Tptr->handle = ThreadCreate(@ThreadUDT.Thread, Tptr)

Do
	Static As Integer I
	MutexLock(Tptr->sync)                 'Mutex (Lock) for main thread
	While Tptr->ready1 <> Tptr->True      'Process loop against spurious wakeups
		CondWait(Tptr->cond1, Tptr->sync) 'CondWait to receive signal1 from user-thread
	Wend
	Tptr->ready1 = Tptr->False
	PSet (Pptr->x, Pptr->y)               'Plotting one point
	I += 1
	Locate 30, 62
	Print I;
	Tptr->ready2 = Tptr->True             'Set ready2
	CondSignal(Tptr->cond2)               'CondSignal to send signal2 to user thread
	If Inkey <> "" Then
		Tptr->quit = Tptr->True           'Set quit
		MutexUnlock(Tptr->sync)           'Mutex (Unlock) for main thread
		Exit Do
	End If
	MutexUnlock(Tptr->sync)               'Mutex (Unlock) for main thread
	Sleep 5, 1
Loop
 

ThreadWait(Tptr->handle)
MutexDestroy(Tptr->sync)
CondDestroy(Tptr->cond1)
CondDestroy(Tptr->cond2)
Delete Tptr
Delete Pptr

Sleep
