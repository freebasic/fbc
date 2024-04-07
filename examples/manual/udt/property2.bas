'' examples/manual/udt/property2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PROPERTY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgProperty
'' --------

  '' True/False
Namespace BOOL
  Const False = 0
  Const True = Not False
End Namespace

Type BitNum
  Num As UInteger
  
	'' Get/Set Properties each with an Index.
  Declare Property NumBit( ByVal Index As Integer ) As Integer
  Declare Property NumBit( ByVal Index As Integer, ByVal Value As Byte )
End Type

  '' Get a bit by it's index.
Property BitNum.NumBit( ByVal Index As Integer ) As Integer
  Return Bit( This.Num, Index )
End Property

  '' Set a bit by it's index.
Property BitNum.NumBit( ByVal Index As Integer, ByVal Value As Byte )

	'' Make sure index is in Integer range.
  If Index >= ( SizeOf(This.Num) * 8 ) Then
	Print "Out of uInteger Range!"
	Exit Property
  Else
	If Index < 0 Then Exit Property
  End If
  
  If Value = BOOL.FALSE Then
	This.Num = BitReset( This.Num, Index )
  End If
  
  If Value = BOOL.TRUE Then
	This.Num = BitSet( This.Num, Index )
  End If
  
End Property


Dim As BitNum Foo


Print "Testing property indexing with data types:"
Print "FOO Number's Value: " & Foo.Num

  '' Set the bit in the number as true.
Foo.NumBit(31) = BOOL.TRUE
Print "Set the 31st bit of FOO"

  '' Print to see if our bit has been changed.
Print "FOO Number's Value: " & Foo.Num
Print "FOO 31st Bit Set? " & Foo.NumBit(31)
Sleep
Print ""
