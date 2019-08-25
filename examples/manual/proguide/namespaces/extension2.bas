'' examples/manual/proguide/namespaces/extension2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNamespaces
'' --------

Namespace A
	Dim As Integer i
End Namespace

Using A

Namespace A
	Dim As Integer j
End Namespace

i = 0  ' Initialize A.i
j = 0  ' Initialize A.j
