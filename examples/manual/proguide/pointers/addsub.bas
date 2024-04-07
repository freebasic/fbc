'' examples/manual/proguide/pointers/addsub.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointer Arithmetic'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPtrArithmetic
'' --------

Dim p As Integer Ptr = New Integer[2]

*p = 1
*(p + 1) = 2
