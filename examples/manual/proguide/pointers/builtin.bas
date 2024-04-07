'' examples/manual/proguide/pointers/builtin.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPointers
'' --------

Dim myInteger As Integer = 10
Dim myPointer As Integer Pointer = @myInteger
*myPointer = 20
Print myInteger
