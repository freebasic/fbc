'' examples/manual/variable/static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStatic
'' --------

Sub f
	'' times called is initially 0
	Static timesCalled As Integer = 0
	timesCalled += 1
	Print "Number of times called: " & timesCalled
End Sub

'' the static variable in f() retains its value between
'' multiple procedure calls.
f()
f()
