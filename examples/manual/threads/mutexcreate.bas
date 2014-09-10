'' examples/manual/threads/mutexcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexCreate
'' --------

'Visual example of threading synchronization using Mutex:
'the "user-defined thread" computes the points coordinates on a circle,
'and the "main thread" plots the points.
'
'If you comment out the lines containing "MutexLock" and "MutexUnlock"
'(inside "user-defined thread" or/and "main thread"),
'the two threads ("user-defined" and "main") will not be in sync,
'and many points will not be plotted on circle (due to non coherent coordinates).

'-----------------------------------------------------------------------------------------------------

Type ThreadUDT                                   'Generic user thread UDT
	Dim handle As Any Ptr                        'Any Ptr handle to user thread
	Dim sync As Any Ptr                          'Any Ptr handle to mutex
	Dim quit As Byte                             'Boolean to end user thread
	Declare Static Sub Thread (ByVal As Any Ptr) 'Generic user thread procedure
	Dim procedure As Sub (ByVal As Any Ptr)      'Procedure(Any Ptr) to be executed by user thread
	Dim p As Any Ptr                             'Any Ptr to pass to procedure executed by user thread
	Const false As Byte = 0                      'Constante "false"
	Const true As Byte = Not False               'Constante "true"
End Type

Static Sub ThreadUDT.Thread (ByVal param As Any Ptr) 'Generic user thread procedure
	Dim tp As ThreadUDT Ptr = param                  'Casting to generic user thread UDT
	Do
	    MutexLock(tp->sync)                          'Mutex (Lock) for user thread
	    tp->procedure(tp->p)                         'Procedure(Any Ptr) to be executed by user thread
	    MutexUnlock(tp->sync)                        'Mutex (Unlock) for user thread
	    Sleep 5
	Loop Until tp->quit = tp->true                   'Test for ending user thread
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
	Sleep 5                            'To increase possibility of uncorrelated data occurrence
	pp->y = y0 + r0 * Sin(teta)
End Sub


Screen 12
Locate 30, 2
Print "<any_key> : exit";

Dim Pptr As Point2D Ptr = New Point2D
Pptr->x = x0 + r0 * Cos(0)
pptr->y = y0 + r0 * Sin(0)

Dim Tptr As ThreadUDT Ptr = New ThreadUDT
Tptr->sync = MutexCreate
Tptr->procedure = @PointOnCircle
Tptr->p = Pptr
Tptr->handle = ThreadCreate(@ThreadUDT.Thread, Tptr)

Do
	MutexLock(Tptr->sync)   'Mutex (Lock) for main thread
	PSet (Pptr->x, Pptr->y)
	MutexUnlock(Tptr->sync) 'Mutex (Unlock) for main thread
	Sleep 5
Loop Until Inkey <> ""
 
Tptr->quit = Tptr->true
ThreadWait(Tptr->handle)
MutexDestroy(Tptr->sync)
Delete Tptr
Delete Pptr
