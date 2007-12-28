'' examples/manual/switches/option-explicit.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionexplicit
'' --------

' compile with -lang deprecated or qb
Option Explicit

'' a must be declared ...
Dim a As Integer

'' ... or else this statement will fail to compile
a = 1
