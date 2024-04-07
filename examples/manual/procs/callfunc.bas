'' examples/manual/procs/callfunc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CALL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb or -lang fblite

#lang "fblite"

Function f ( ) As Integer
f = 42
End Function

Call f ' execute function f, but ignore the answer
