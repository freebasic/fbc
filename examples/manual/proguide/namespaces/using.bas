'' examples/manual/proguide/namespaces/using.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Dim As Integer i  ' Declaration of A.i
	Dim As Integer j  ' Declaration of A.j
End Namespace

Using A  ' Namespace A identifiers are also used
i = 1  ' Equivalent to A.i
j = 1  ' Equivalent to A.j
