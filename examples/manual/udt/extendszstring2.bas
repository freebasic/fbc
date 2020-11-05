'' examples/manual/udt/extendszstring2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtendsZstring
'' --------

Type vZstring Extends ZString
  Public:
	Declare Constructor (ByVal pz As Const ZString Ptr = 0)
	Declare Operator Cast () ByRef As ZString
	Declare Operator Let (ByVal pz As Const ZString Ptr)
	Declare Operator [] (ByVal index As Integer) ByRef As UByte
	Declare Destructor ()
  Private:
	Dim As ZString Ptr p
	Dim As UInteger l
End Type

Constructor vZstring (ByVal pz As Const ZString Ptr = 0)
  This.l = Len(*pz)
  This.p = CAllocate(This.l + 1, SizeOf(ZString))
  *This.p = *pz
End Constructor

Operator vZstring.Cast () ByRef As ZString
  Return *This.p
End Operator

Operator vZstring.Let (ByVal pz As Const ZString Ptr)
  If This.l < Len(*pz) Then
	Deallocate(This.p)
	This.l = Len(*pz)
	This.p = CAllocate(This.l + 1, SizeOf(ZString))
  End If
  *This.p = *pz
End Operator

Operator vZstring.[] (ByVal index As Integer) ByRef As UByte
  Return This.p[index]
End Operator

Destructor vZstring ()
  Deallocate(This.p)
End Destructor

Operator Len (ByRef v As vZstring) As Integer
  Return Len(Type<String>(v))        '' found nothing better than this
End Operator                         ''     (or: 'Return Len(Str(v))')

Dim As vZstring v = "FreeBASIC"
Print "'" & v & "'", Len(v)

Dim As ZString * 256 z
z = *StrPtr(v)                       '' 'error 24: Invalid data types' without 'Extends Zstring'
Print "'" & z & "'", Len(z)

v &= Space(2)
Print "'" & v & "'", Len(v)
RSet v, "FreeBASIC"                  '' 'error 24: Invalid data types' without 'Extends Zstring'
Print "'" & v & "'", Len(v)          ''     ('Cast' must return a modifiable reference)

Select Case v                        '' 'error 24: Invalid data types' without 'Extends Zstring'
Case Type<vZstring>(Trim(v) & "  ")
  Print "Left justified"
Case Type<vZstring>("  " & Trim(v))
  Print "Right justified"
End Select

v[0] = Asc("-")
Print "'" & v & "'", Len(v)

'Print "'" & Right(v, 5) & "'"      '' 'Right' does not yet support types with 'Extends Zstring'
Print "'" & Right(Str(v), 5) & "'"  '' workaround (or: 'Right(Type<String>(v), 5)')

Sleep
	
