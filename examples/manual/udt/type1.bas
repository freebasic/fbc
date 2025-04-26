'' examples/manual/udt/type1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPE (UDT)'
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

/'
Alternatively (See 'Type (Temporary)' page) we could use
Dim c As clr
c = Type <clr> (255, 128, 64)
or
c = Type(255, 128, 64)  '' implicit typename
'/
