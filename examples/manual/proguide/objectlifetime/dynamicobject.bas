'' examples/manual/proguide/objectlifetime/dynamicobject.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Dynamic Object and Data Lifetime'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgObjectLifetime
'' --------

Type complexUDT
	Public:
		Declare Constructor ()
		Declare Constructor (ByVal p As ZString Ptr)
		Declare Operator Let (ByVal p As ZString Ptr)
		Declare Operator Cast () As String
		Declare Property info () As String ' allocation address, allocation size, string length
		Declare Destructor ()
	Private:
		Dim As ZString Ptr pz
End Type

Declare Sub prntInfo_printString (ByRef u As complexUDT)
  
  
Print "'Dim Byref As complexUDT ref = *New complexUDT(""Beginning"")':"
Dim ByRef As complexUDT ref = *New complexUDT("Beginning")
prntInfo_printString(ref)

Print "'ref = """"':"
ref = ""
prntInfo_printString(ref)

Print "'ref = ""FreeBASIC""':"
ref = "FreeBASIC"
prntInfo_printString(ref)

Print "'ref = ""Programmer's Guide / Declarations / Dynamic Object and Data Lifetime""':"
ref = "Programmer's Guide / Declarations / Dynamic Object and Data Lifetime"
prntInfo_printString(ref)

Print "'ref.Destructor()':"
ref.Destructor()
prntInfo_printString(ref)

Print "'ref.Constructor()':"
ref.Constructor()
prntInfo_printString(ref)

Print "'ref.Constructor(""End"")':"
ref.Constructor("End")
prntInfo_printString(ref)

Print "'Delete @ref':"
Delete @ref
@ref = 0 ' systematic safety to avoid double-delete on same allocation

Sleep


Constructor complexUDT ()
	Print "    complexUDT.Constructor()"
	This.pz = Reallocate(This.pz, 1)
	(*This.pz)[0] = 0
End Constructor

Constructor complexUDT (ByVal p As ZString Ptr)
	Print "    complexUDT.Constructor(Byval As Zstring Ptr)"
	This.pz = Reallocate(This.pz, Len(*p) + 1)
	*This.pz = *p
End Constructor

Operator complexUDT.Let (ByVal p As ZString Ptr)
	Print "    complexUDT.Let(Byval As Zstring Ptr)"
	This.pz = Reallocate(This.pz, Len(*p) + 1)
	*This.pz = *p
End Operator

Operator complexUDT.Cast () As String
	Return """" & *This.pz & """"
End Operator

Property complexUDT.info () As String
	Return "&h" & Hex(This.pz, SizeOf(Any Ptr) * 2) & ", " & _     ' allocation address
			Len(*This.pz) + Sgn(Cast(Integer, This.pz)) & ", " & _ ' allocation size
			Len(*This.pz)                                          ' string length
End Property

Destructor complexUDT ()
	Print "    complexUDT.Destructor()"
	This.pz = Reallocate(This.pz, 0)
End Destructor


Sub prntInfo_printString (ByRef u As complexUDT)
	Print "        " & u.info
	Print "        " & u
	Print
End Sub
			
