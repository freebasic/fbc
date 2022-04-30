'' examples/manual/meta/static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '$STATIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMetaStatic
'' --------

' compile with -lang fblite or qb

#lang "fblite"

'$dynamic
Dim a(100)   '<<this array will be variable-length
'$static
Dim b(100)   '<<this array will be fixed-length
