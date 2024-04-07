'' examples/manual/debug/assertwarn.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ASSERTWARN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAssertwarn
'' --------

Sub foo
  Dim a As Integer
  a=0
  AssertWarn(a=1)
End Sub

foo 

'' If -g is used this code prints: test.bas(3): assertion failed at FOO: a=1 
