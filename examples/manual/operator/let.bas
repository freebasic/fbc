'' examples/manual/operator/let.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Let (Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLet
'' --------

Type UDT
  Public:
	Declare Constructor (ByVal zp As Const ZString Ptr)  ''constructor with string initializer
	Declare Operator Let (ByRef rhs As UDT)              ''operator Let (assignment)
	Declare Function getString () As String              ''function to get string
	Declare Destructor ()                                ''destructor
  Private:         
	Dim zp As ZString Ptr                                ''private pointer to avoid direct access
End Type

Constructor UDT (ByVal zp As Const ZString Ptr)
  This.zp = CAllocate(Len(*zp) + 1)
  *This.zp = *zp
End Constructor

Operator UDT.Let (ByRef rhs As UDT)
  If @This <> @rhs Then  '' check for self-assignment to avoid object destruction
	Deallocate(This.zp)
	This.zp = CAllocate(Len(*rhs.zp) + 1)
	*This.zp = *rhs.zp
  End If
End Operator

Function UDT.getString () As String
  Return *This.zp
End Function

Destructor UDT ()
  Deallocate(This.zp)
End Destructor


Dim u As UDT = UDT("")
u = Type<UDT>("Thanks to the overloading operator Let (assign)")
Print u.getString
Sleep
