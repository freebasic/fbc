'' examples/manual/switches/option-base.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionbase
'' --------

'' Compile with -lang deprecated or qb
Option Base 1
Dim foo(10)
Print "foo contains elements between " & LBound(foo) & " and " & UBound(foo)
