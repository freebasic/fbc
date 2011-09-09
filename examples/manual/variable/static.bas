'' examples/manual/variable/static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStatic
'' --------

Sub f
	'' static variables are initialized to 0 by default
	Static i As Integer
	i += 1
	Print "Number of times called: " & i
End Sub

'' the static variable in f() retains its value between
'' multiple procedure calls.
f()
f()
