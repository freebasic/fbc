'' examples/manual/proguide/namespaces/extension1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
