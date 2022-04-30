'' examples/manual/udt/type3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

Function UbyteToOctalString (ByVal b As UByte) As String
 
	Union UbyteOctal
		number As UByte
		Type
			d0 : 3 As UByte
			d1 : 3 As UByte
			d2 : 2 As UByte
		End Type
	End Union
 
	Dim uo As UbyteOctal
	uo.number = b
	Return uo.d2 & uo.d1 & uo.d0
 
End Function


For I As Integer = 0 To 255
	Print Using "###: "; I;
''    Print Oct(I, 3),
	Print UbyteToOctalString(I),  '' this line is thus equivalent to the previous one
Next I
Print

Sleep
