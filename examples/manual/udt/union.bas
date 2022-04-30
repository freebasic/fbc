'' examples/manual/udt/union.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 0: Little-endianness
' For larger integer values (as the following Ulong data type),
'   bytes are arranged in memory in 'little-endian' byte order
'   (the least significant byte gets stored first).

Union UDU
   ul As ULong      ' 32-bit data type
   Type
	  ub0 As UByte  ' 8-bit data type
	  ub1 As UByte  ' 8-bit data type
	  ub2 As UByte  ' 8-bit data type
	  ub3 As UByte  ' 8-bit data type
   End Type
End Union

Dim As UDU u
u.ul = &h12345678
Print Hex(u.ul)                                       ' Result: 12345678
Print Hex(u.ub3), Hex(u.ub2), Hex(u.ub1), Hex(u.ub0)  ' Result: 12   34   56   78

Sleep
