'' examples/manual/proguide/udt/ctordtor-dynamicarray3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

#include "crt/string.bi"

Type UDT
	Dim As Integer array(Any)
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
	If UBound(u.array) >= LBound(u.array) Then  '' explicit array sizing and copying
		ReDim This.array(LBound(u.array) To UBound(u.array))
		memcpy(@This.array(LBound(This.array)), @u.array(LBound(u.array)), (UBound(u.array) - LBound(u.array) + 1) * SizeOf(@u.array(LBound(u.array))))
	End If
End Constructor

Operator UDT.Let (ByRef u As UDT)
	'code for user fields in copy-assignement operator
	If @This <> @u And UBound(u.array) >= LBound(u.array) Then  '' explicit array sizing and copying
		ReDim This.array(LBound(u.array) To UBound(u.array))
		memcpy(@This.array(LBound(This.array)), @u.array(LBound(u.array)), (UBound(u.array) - LBound(u.array) + 1) * SizeOf(@u.array(LBound(u.array))))
	End If
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
			
