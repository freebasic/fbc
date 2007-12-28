'' examples/manual/array/clear.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgClear
'' --------

Dim array(1 To 100) As Integer
Clear Array(1), 0, Len(Array(1)) * UBound(Array)
