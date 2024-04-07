'' examples/manual/proguide/opovld/smart-pointer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Overloading'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
'' --------

Type UDT
	Declare Constructor ()
	Declare Destructor ()
	Dim As String s = "object #0"
End Type

Constructor UDT ()
	Print "  UDT construction "; @This
End Constructor

Destructor UDT ()
	Print "  UDT destruction "; @This
End Destructor

Type SmartPointer
	Public:
		Declare Constructor ()                            '' to construct smart pointer (and UDT object)
		Declare Constructor (ByRef rhs As SmartPointer)   '' to copy construct smart pointer
		Declare Operator Cast () As UDT Ptr               '' to cast private UDT pointer (for read only)
		Declare Destructor ()                             '' to destroy smart pointer (and UDT object)
	Private:
		Dim As UDT Ptr p                                  '' private UDT pointer
		Declare Operator Let (ByRef rhs As SmartPointer)  '' to disallow assignment (to avoid copy of real pointers)
End Type

Constructor SmartPointer ()
	Print "SmartPointer construction "; @This
	This.p = New UDT
End Constructor

Constructor SmartPointer (ByRef rhs As SmartPointer)
	Print "SmartPointer copy-construction "; @This; " from "; @rhs
	This.p = New UDT
	*This.p = *rhs.p
End Constructor

Operator SmartPointer.Cast () As UDT Ptr
	Return This.p
End Operator

Destructor SmartPointer ()
	Print "SmartPointer destruction "; @This
	Delete This.p
End Destructor

Operator * (ByRef sp As SmartPointer) ByRef As UDT   '' overloaded operator '*'
	Print "SmartPointer operator '*'"
	Return *Cast(UDT Ptr, sp)                        ''    (returning byref)
End Operator                                         ''    to behave as pointer
 
Operator -> (ByRef sp As SmartPointer) ByRef As UDT  '' overloaded operator '->'
	Print "SmartPointer operator '->'"
	Return *Cast(UDT Ptr, sp)                        ''    (returning byref)
End Operator                                         ''    to behave as pointer
 

Scope
	Dim sp1 As SmartPointer
	Print "'" & sp1->s & "'"
	sp1->s = "object #1"
	Print "'" & sp1->s & "'"
	Print
 
	Dim sp2 As SmartPointer = sp1
	Print "'" & (*sp2).s & "'"
	(*sp2).s = "object #2"
	Print "'" & (*sp2).s & "'"
	Print
 
	Dim sp3 As SmartPointer = sp1
	Print "'" & sp3->s & "'"
	*sp3 = *sp2
	Print "'" & sp3->s & "'"
	sp3->s = "object #3"
	Print "'" & sp3->s & "'"
	Print
End Scope

Sleep
			
