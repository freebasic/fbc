'' examples/manual/misc/sizeof-udt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSizeof
'' --------

Type bar
	a As Integer
	b As Double
End Type
Dim foo As bar
Print SizeOf(foo)
