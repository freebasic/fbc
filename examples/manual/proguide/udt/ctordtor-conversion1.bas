'' examples/manual/proguide/udt/ctordtor-conversion1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #1)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type UDT Extends Object
	Declare Constructor ()
	Declare Constructor (ByVal i0 As Integer)
	Declare Destructor ()
	Dim As Integer i
End Type

Constructor UDT ()
	Print "   => UDT.default-constructor", @This
End Constructor

Constructor UDT (ByVal i0 As Integer)
	Print "   => UDT.conversion-constructor", @This
	This.i = i0
End Constructor

Function RtnI (ByRef u As UDT) As Integer
	Return u.i
End Function
 
Destructor UDT ()
	Print "   => UDT.destructor", , @This
End Destructor

Scope
	Print "Construction: 'Dim As UDT u'"
	Dim As UDT u
	Print
	Print "Assignment: 'u = 123'"
	Print "      " & RtnI(123)            ''  RtnI(123): implicite conversion using the conversion-constructor,
	'                                     ''             short_cut of RtnI(UDT(123))
	Print
	Print "Going out scope: 'End Scope'"
End Scope

Sleep
				
