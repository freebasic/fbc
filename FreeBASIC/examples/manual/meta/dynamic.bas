'' examples/manual/meta/dynamic.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMetaDynamic
'' --------

' compile with -lang fblite or qb

#lang "fblite"

'$DYNAMIC
Dim a(100)
'......
ReDim a(200)
