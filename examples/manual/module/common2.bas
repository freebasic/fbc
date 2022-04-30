'' examples/manual/module/common2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COMMON'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommon
'' --------

'' common2.bas

Common Shared foo() As Double

Sub initme()
  foo(0) = 4*Atn(1)
  foo(1) = foo(0)/3
  foo(2) = foo(1)*2
End Sub
