'' examples/manual/udt/type1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

Type clr
	red As UByte
	green As UByte
	blue As UByte
End Type

Dim c As clr
c.red = 255
c.green = 128
c.blue = 64
