'' examples/manual/check/KeyPgOptionbase_1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION BASE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionbase
'' --------

'' Compile with the "-lang qb" or "-lang fblite" compiler switches

#lang "fblite"

Dim foo(10) As Integer      ' declares an array with indices 0-10

Option Base 5

Dim bar(15) As Integer      ' declares an array with indices 5-15
Dim baz(0 To 4) As Integer  ' declares an array with indices 0-4
