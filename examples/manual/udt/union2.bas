'' examples/manual/udt/union2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 2: Alternative to RGBA keyword and allowing to retrieve elementary colors values
Union BGRA_UNION
   colour As ULong
   Type
	  blue  As UByte
	  green As UByte
	  red   As UByte
	  Alpha As UByte
   End Type
End Union

Dim ubgra As BGRA_UNION

' Setting the individual color values...
ubgra.red = &h33
ubgra.green = &hcc
ubgra.blue = &h66
' We can get a ULONG value
Print Hex(ubgra.colour)  ' Result: 33CC66
Print

' Setting a ULONG value...
ubgra.colour = &h228844
' We can get the individual color values
Print Hex(ubgra.red)    ' Result: 22
Print Hex(ubgra.green)  ' Result: 88
Print Hex(ubgra.blue)   ' Result: 44
Print

Sleep
