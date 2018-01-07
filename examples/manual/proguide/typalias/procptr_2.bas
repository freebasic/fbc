'' examples/manual/proguide/typalias/procptr_2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Dim pf As Function() As Integer Ptr

Type pf_t As Function() As Integer
Dim ppf As pf_t Ptr
	
