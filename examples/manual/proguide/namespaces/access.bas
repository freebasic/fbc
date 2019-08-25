'' examples/manual/proguide/namespaces/access.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
