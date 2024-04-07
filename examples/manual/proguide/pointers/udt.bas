'' examples/manual/proguide/pointers/udt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPointers
'' --------

Type myType
	a As Integer
	b As Double
End Type

Dim x As myType
Dim p As myType Pointer = @x

'' 1) dereference the pointer and use the member access operator:
(*p).a = 10
(*p).b = 12.34

'' 2) use the shorthand form of the member access operator:
Print p->a
Print p->b
