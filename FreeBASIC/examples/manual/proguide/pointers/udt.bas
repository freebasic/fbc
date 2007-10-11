'' examples/manual/proguide/pointers/udt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPointers
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
