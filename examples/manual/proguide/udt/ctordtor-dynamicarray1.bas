'' examples/manual/proguide/udt/ctordtor-dynamicarray1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type UDT
	Dim As Integer array(Any)
End Type

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
			
