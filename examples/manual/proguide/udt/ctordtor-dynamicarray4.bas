'' examples/manual/proguide/udt/ctordtor-dynamicarray4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type UDT0
	Dim As Integer array(Any)
End Type

Type UDT Extends UDT0
	'user fields
	Declare Constructor ()
	Declare Constructor (ByRef u As UDT)
	Declare Operator Let (ByRef u As UDT)
End Type

Constructor UDT ()
	'code for user fields in constructor
End Constructor

Constructor UDT (ByRef u As UDT)
	'code for user fields in copy-constructor
	Base(u)  '' inherited array sizing and copying from Base copy-constructor
End Constructor

Operator UDT.Let (ByRef u As UDT)
	'code for user fields in copy-assignement operator
	Cast(UDT0, This) = u  '' inherited array sizing and copying from Base copy-assignement operator
End Operator

Dim As UDT u1, u2

ReDim u1.array(1 To 9)
For I As Integer = LBound(u1.array) To UBound(u1.array)
	u1.array(I) = I
Next I
 
u2 = u1
For I As Integer = LBound(u2.array) To UBound(u2.array)
	Print u2.array(I);
Next I
Print

Dim As UDT u3 = u1
For I As Integer = LBound(u3.array) To UBound(u3.array)
	Print u3.array(I);
Next I
Print

Sleep
			
