'' examples/manual/strings/lset-udt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLset
'' --------

Type mytype1
	x As Integer
	y As Integer
End Type

Type mytype2
	z As Integer
End Type

Dim a As mytype1 , b As mytype2
b.z = 1234

LSet a, b
Print a.x
