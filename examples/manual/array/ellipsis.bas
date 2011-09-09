'' examples/manual/array/ellipsis.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDots
'' --------

Dim As Integer myarray(0 To ...) = {0, 1, 2, 3}
Print LBound(myarray), UBound(myarray)   '' 0, 3
