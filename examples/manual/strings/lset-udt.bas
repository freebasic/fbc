'' examples/manual/strings/lset-udt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLset
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
