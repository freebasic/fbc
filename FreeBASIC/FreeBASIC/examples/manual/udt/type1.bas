'' examples/manual/udt/type1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
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
