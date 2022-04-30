'' examples/manual/variable/static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STATIC'
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
