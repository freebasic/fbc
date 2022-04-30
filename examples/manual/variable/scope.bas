'' examples/manual/variable/scope.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCOPE...END SCOPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScope
'' --------

Dim As Integer x = 5, y = 2
Print "x ="; x; ", "; "y ="; y
Scope
	Dim x As Integer = 3
	Print "x ="; x; ", "; "y ="; y
	Scope
		Dim y As Integer = 4
		Print "x ="; x; ", "; "y ="; y
	End Scope
End Scope
Print "x ="; x; ", "; "y ="; y
