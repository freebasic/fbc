'' examples/manual/procs/callfunc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb or -lang fblite

#lang "fblite"

Function f ( ) As Integer
f = 42
End Function

Call f ' execute function f, but ignore the answer
