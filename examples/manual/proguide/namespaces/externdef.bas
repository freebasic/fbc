'' examples/manual/proguide/namespaces/externdef.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Declare Function f () As Integer  ' Declaration of f() in Namespace A (A.f())
End Namespace

Function A.f () As Integer  ' Definition of f() from Namespace A (A.f())
	Return 0
End Function
