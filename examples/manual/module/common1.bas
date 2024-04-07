'' examples/manual/module/common1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COMMON'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommon
'' --------

'' common1.bas

Declare Sub initme()

Common Shared foo() As Double

ReDim foo(0 To 2)

initme()

Print foo(0), foo(1), foo(2)
