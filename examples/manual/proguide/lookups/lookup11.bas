'' examples/manual/proguide/lookups/lookup11.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgIdentifierLookup
'' --------

Dim Shared As ZString * 32 duplicateVar = "   ..duplicateVar"

Namespace M
	Dim As ZString *32 duplicateVar = "   M.duplicateVar"
End Namespace

Namespace N
	Using M
	Dim As ZString * 32 duplicateVar = "   N.duplicateVar"
	Type Parent Extends Object
		Dim As ZString * 32 duplicateVar = "   N.Parent.duplicateVar"
	End Type
	Type Child Extends Parent
		Dim As ZString * 32 duplicateVar = "   N.Child.duplicateVar"
	End Type
	Type GrandChild Extends Child
		Dim As ZString * 32 duplicateVar = "   N.GrandChild.duplicateVar"
		Declare Sub test()
	End Type
	Sub GrandChild.test()
		Using M  '' useless, but just to demonstrate that does not increase priority level of imported namespace
		Print duplicateVar
	End Sub
End Namespace

Print "From Type:"
Dim As N.GrandChild gc
' "gc.test()" calls the unqualified identifier "duplicateVar"
' "Print gc.duplicateVar" calls the qualified identifier "gc.duplicateVar"

gc.test()                '' "N.GrandChild.duplicateVar" expected : in [1] current namespace/type
Print gc.duplicateVar    '' "N.GrandChild.duplicateVar" expected : in [1] current namespace/type

Print
Sleep
