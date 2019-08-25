'' examples/manual/proguide/namespaces/using.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
