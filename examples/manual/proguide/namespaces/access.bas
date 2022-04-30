'' examples/manual/proguide/namespaces/access.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Namespaces'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Dim As Integer i  ' Declare i in the global scope

Namespace A
	Dim As Integer i = 2  ' Declare i in Namespace A
	Dim As Integer j = 3  ' Declare j in Namespace A
End Namespace

i = 1    ' Use i from global scope (.i)
A.i = 4  ' Use i from Namespace A (A.i)
