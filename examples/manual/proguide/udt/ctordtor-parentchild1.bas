'' examples/manual/proguide/udt/ctordtor-parentchild1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors
'' --------

Type Parent  '' declare the parent type
	Dim As Integer I
	Declare Constructor ()
	Declare Constructor (ByVal i0 As Integer)
	Declare Destructor ()
End Type

Constructor Parent ()  '' define parent Type constructor
	Print "Parent.Constructor()"
End Constructor

Constructor Parent (ByVal i0 As Integer)  '' define parent Type constructor
	This.I = i0
	Print "Parent.Constructor(Byval As Integer)"
End Constructor

Destructor Parent ()  '' define parent Type destructor
	Print "Parent.Destructor()"
End Destructor

Type Child Extends Parent  '' declare the child Type
	Declare Constructor ()
	Declare Destructor ()
End Type

Constructor Child ()  '' define child Type default constructor
	Base(123)         '' authorize only on the first code line of the constructor body
	Print "  Child.Constructor()"
End Constructor

Destructor Child ()  '' define child Type destructor
	Print "  Child.Destructor()"
End Destructor


Scope
	Dim As Child c
	Print
End Scope

Sleep
			
