'' examples/manual/proguide/typalias/procptr_2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type Aliases'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Dim pf As Function() As Integer Ptr

Type pf_t As Function() As Integer
Dim ppf As pf_t Ptr
	
