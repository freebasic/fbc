'' examples/manual/debug/assert.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
