'' examples/manual/proguide/namespaces/nested.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Dim As Integer i  ' (A.i)
	Namespace B
		Dim As Integer j  ' (A.B.j)
	End Namespace
End Namespace
