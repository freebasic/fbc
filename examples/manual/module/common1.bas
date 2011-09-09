'' examples/manual/module/common1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommon
'' --------

'' common1.bas

Declare Sub initme()

Common Shared foo() As Double

Redim foo(0 To 2) As Double

initme()

Print foo(0), foo(1), foo(2)
