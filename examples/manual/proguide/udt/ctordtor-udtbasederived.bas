'' examples/manual/proguide/udt/ctordtor-udtbasederived.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #2)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors2
'' --------

#define UDTbase_copy_assignment_operator
#define UDTbase_default_constructor
#define UDTbase_copy_constructor

#define UDTderived_copy_assignment_operator
#define UDTderived_default_constructor
#define UDTderived_copy_constructor
#define UDTderived_object_field_with_constructor


Type UDTbase
	#ifdef UDTbase_copy_assignment_operator
	Declare Operator Let (ByRef u1 As UDTbase)
	#endif
	#ifdef UDTbase_copy_constructor
	Declare Constructor ()
	Declare Constructor (ByRef u1 As UDTbase)
	#endif
	#ifdef UDTbase_default_constructor
	#ifndef UDTbase_copy_constructor
	Declare Constructor ()
	#endif
	#endif
	Declare Destructor ()
	Dim As Integer i1
End Type

#ifdef UDTbase_copy_assignment_operator
Operator UDTbase.Let (ByRef u1 As UDTbase)
	Print "   => UDTbase.copy-assignment", @This & " from " & @u1
	This.i1 = u1.i1
End Operator
#endif
#ifdef UDTbase_copy_constructor
Constructor UDTbase ()
	Print "   => UDTbase.default-constructor", @This
End Constructor
Constructor UDTbase (ByRef u1 As UDTbase)
	Print "   => UDTbase.copy-constructor", @This & " from " & @u1
	This.i1 = u1.i1
End Constructor
#endif
#ifdef UDTbase_default_constructor
#ifndef UDTbase_copy_constructor
Constructor UDTbase ()
	Print "   => UDTbase.default-constructor", @This
End Constructor
#endif
#endif
Destructor UDTbase ()
	Print "   => UDTbase.destructor", , @This
End Destructor

Type UDTderived Extends UDTbase
	#ifdef UDTderived_copy_assignment_operator
	Declare Operator Let (ByRef u2 As UDTderived)
	#endif
	#ifdef UDTderived_copy_constructor
	Declare Constructor ()
	Declare Constructor (ByRef u2 As UDTderived)
	#endif
	#ifdef UDTderived_default_constructor
	#ifndef UDTderived_copy_constructor
	Declare Constructor ()
	#endif
	#endif
	Declare Destructor ()
	Dim As Integer i2
	#ifdef UDTderived_object_field_with_constructor
	Dim As String s2
	#endif
End Type

#ifdef UDTderived_copy_assignment_operator
Operator UDTderived.Let (ByRef u2 As UDTderived)
	Print "   => UDTderived.copy-assignment", @This & " from " & @u2
	This.i2 = u2.i2
	This.i1 = u2.i1
End Operator
#endif
#ifdef UDTderived_copy_constructor
Constructor UDTderived ()
	Print "   => UDTderived.default-constructor", @This
End Constructor
Constructor UDTderived (ByRef u2 As UDTderived)
	Print "   => UDTderived.copy-constructor", @This & " from " & @u2
	This.i2 = u2.i2
	This.i1 = u2.i1
End Constructor
#endif
#ifdef UDTderived_default_constructor
#ifndef UDTderived_copy_constructor
Constructor UDTderived ()
	Print "   => UDTderived.default-constructor", @This
End Constructor
#endif
#endif
Destructor UDTderived ()
	Print "   => UDTderived.destructor", , @This
End Destructor

Scope
	Print "Construction: 'Dim As UDTderived a, b : a.i1 = 1 : a.i2 = 2'"
	Dim As UDTderived a, b : a.i1 = 1 : a.i2 = 2
	Print "      " & a.i1
	Print "      " & a.i2
	Print
	Print "Assignment: 'b = a'"
	b = a
	Print "      " & b.i1
	Print "      " & b.i2
	Print
	Print "Copy-construction: 'Dim As UDTderived c = a'"
	Dim As UDTderived c = a
	Print "      " & c.i1
	Print "      " & c.i2
	Print
	Print "Going out scope: 'End Scope'"
End Scope

Sleep
			
