'' examples/manual/debug/assertwarn.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAssertwarn
'' --------

Sub foo
  Dim a As Integer
  a=0
  AssertWarn(a=1)
End Sub

foo 

'' If -g is used this code prints: test.bas(3): assertion failed at FOO: a=1 
