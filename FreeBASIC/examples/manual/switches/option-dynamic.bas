'' examples/manual/switches/option-dynamic.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptiondynamic
'' --------

' compile with -lang deprecated
Option Dynamic
Dim a(100)
'......
ReDim a(200)
