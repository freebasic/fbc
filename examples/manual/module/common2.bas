'' examples/manual/module/common2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommon
'' --------

'' common2.bas

Common Shared foo() As Double

Sub initme()
  foo(0) = 4*Atn(1)
  foo(1) = foo(0)/3
  foo(2) = foo(1)*2
End Sub
