'' examples/manual/udt/union.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 1: bitfields.
Type unitType
 Union
  Dim attributeMask As UInteger
  Type    ' 32-bit uintegers can support up to 32 attributes.
   isMilitary         : 1 As UInteger
   isMerchant         : 1 As UInteger
  End Type
 End Union
End Type

Dim myunit As unitType
myunit.isMilitary = 1
myunit.isMerchant = 1
Print myunit.isMilitary    ' Result: 1.
Print myunit.isMerchant    ' Result: 1.
Print myunit.attributeMask ' Result: 3.
Sleep

' Example 2.
' Define our union.
Union AUnion
	a As UByte
	b As Integer
End Union
' Define a composite type.
Type CompType
	s As String * 20
	ui As Byte 'Flag to tell us what to use in union.
	Union 
	    au As UByte
	    bu As Integer
	End Union
End Type

' Flags to let us know what to use in union.
' You can only use a single element of a union.
Const IsInteger = 1
Const IsUByte = 2

Dim MyUnion As AUnion
Dim MyComposite As CompType

' Can only set one value in union.
MyUnion.a = 128

MyComposite.s = "Type + Union"
MyComposite.ui = IsInteger ' Tells us this is an integer union.
MyComposite.bu = 1500

Print "Union: ";MyUnion.a

Print "Composite: ";
If MyComposite.ui = IsInteger Then
	Print MyComposite.bu
ElseIf MyComposite.ui = IsUByte Then
	Print MyComposite.au
Else
	Print "Unknown type."
End If

Sleep
