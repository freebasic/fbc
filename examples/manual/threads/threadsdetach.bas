'' examples/manual/threads/threadsdetach.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadDetach
'' --------

#include "fbthread.bi"

Sub mythread( ByVal param As Any Ptr )
	Print "hi!"
End Sub

Var thread = ThreadCreate( @mythread )
ThreadDetach( thread )

ThreadDetach( ThreadCreate( @mythread ) )

Sleep
