'' examples/manual/proguide/pointers/builtin.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPointers
'' --------

Dim myInteger As Integer = 10
Dim myPointer As Integer Pointer = @myInteger
*myPointer = 20
Print myInteger
