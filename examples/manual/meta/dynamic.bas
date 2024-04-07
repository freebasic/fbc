'' examples/manual/meta/dynamic.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '$DYNAMIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMetaDynamic
'' --------

' compile with -lang fblite or qb

#lang "fblite"

'$DYNAMIC
Dim a(100)
'......
ReDim a(200)
