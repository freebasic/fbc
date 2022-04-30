'' examples/manual/proguide/namespaces/nested.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Dim As Integer i  ' (A.i)
	Namespace B
		Dim As Integer j  ' (A.B.j)
	End Namespace
End Namespace
