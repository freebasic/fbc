'' examples/manual/udt/operator3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPERATOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOperator
'' --------

'' operator3.bas

'' A smart pointer is an object which behaves like a pointer but does more than a pointer:
'' - This object is flexible as a pointer and has the advantage of being an object,
''   like constructor and destructor called automatically.
'' - Therefore, the destructor of the smart pointer will be automatically called
''   when this object goes out of scope, and it will delete the user pointer.

'' Example of simplest smart pointers for byte buffers:
'' - Constructor and destructor allow to allocate, deallocate, and resize the byte buffer.
'' - Pointer index operator allows to access buffer elements.
'' - Copy-constructor and let-operator are just declared in private section,
''   in order to disallow copy construction and any assignment.

Type smartByteBuffer
  Public:
	Declare Constructor (ByVal size As UInteger = 0)
	Declare Operator [] (ByVal index As UInteger) ByRef As Byte
	Declare Destructor ()
  Private:
	Declare Constructor (ByRef rhs As smartByteBuffer)
	Declare Operator Let (ByRef rhs As smartByteBuffer)
	Dim As Byte Ptr psbb
End Type

Constructor smartByteBuffer (ByVal size As UInteger = 0)
  This.destructor()
  If size > 0 Then
	This.psbb = New Byte[size]
	Print "Byte buffer allocated"
  End If
End Constructor

Operator smartByteBuffer.[] (ByVal index As UInteger) ByRef As Byte
  Return This.psbb[index]
End Operator

Destructor smartByteBuffer ()
  If This.psbb > 0 Then
	Delete[] This.psbb
	This.psbb = 0
	Print "Byte buffer deallocated"
  End If
End Destructor

Scope
  Dim As smartByteBuffer sbb = smartByteBuffer(256)
  For I As Integer = 0 To 255
	sbb[I] = I - 128
  Next I
  Print
  For I As Integer = 0 To 255
	Print Using "#####"; sbb[I];
  Next I
  Print
End Scope
