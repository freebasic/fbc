'' examples/manual/threads/threadsdetach.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'THREADDETACH'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadDetach
'' --------

#include "fbthread.bi"

Sub mythread( ByVal param As Any Ptr )
	Print "hi!"
End Sub

Dim As Any Ptr thread = ThreadCreate( @mythread )
ThreadDetach( thread )
'' or
ThreadDetach( ThreadCreate( @mythread ) )

Sleep
