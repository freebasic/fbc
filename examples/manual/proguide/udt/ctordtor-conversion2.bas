'' examples/manual/proguide/udt/ctordtor-conversion2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type point2D
	Declare Constructor (ByVal x0 As Integer = 0, ByVal y0 As Integer = 0)
	Declare Operator Cast () As String
	Dim As Integer x, y
End Type

Constructor point2D (ByVal x0 As Integer = 0, ByVal y0 As Integer = 0)
	This.x = x0
	This.y = y0
End Constructor

Operator point2D.cast () As String
	Return "(" & This.x & ", " & This.y & ")"
End Operator

Operator + (ByRef v0 As point2D, ByRef v1 As point2D) As point2D
	Return Type(v0.x + v1.x, v0.y + v1.y)
End Operator

Operator * (ByRef v0 As point2D, ByRef v1 As point2D) As Integer
	Return v0.x * v1.x + v0.y * v1.y
End Operator

Print "Construction of v1: 'Dim As point2D v1 = point2D(2, 3)'"
Dim As point2D v1 = point2D(2, 3)
Print "  => " & v1
Print
Print "Addition to v1: 'v1 + 4'"
Print "  => " & v1 + 4                  ''  4: implicite conversion using the conversion-constructor,
'                                       ''             short_cut of point2D(4, ) or point2D(4)
Print
Print "Multiplication of v1: 'v1 * 5'"
Print "  => " & v1 * 5                  ''  5: implicite conversion using the conversion-constructor,
'                                       ''             short_cut of point2D(5, ) or point2D(5)
Sleep
				
