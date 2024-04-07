'' examples/manual/proguide/namespaces/extension1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A  ' Declaration of Namespace A
	Dim As Integer i
End Namespace

Namespace B  ' Declaration of Namespace B
	Dim As Integer i
End Namespace

Namespace A  ' Extension of Namespace A
	Dim As Integer j
End Namespace
