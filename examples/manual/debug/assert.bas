'' examples/manual/debug/assert.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ASSERT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAssert
'' --------

Sub foo
 Dim a As Integer
 a=0
 Assert(a=1)
End Sub

foo 

'' If -g or -eassert is used, this code stops with: test.bas(3): assertion failed at FOO: a=1 
