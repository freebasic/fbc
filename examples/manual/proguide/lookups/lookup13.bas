'' examples/manual/proguide/lookups/lookup13.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Identifier Look-ups in namespaces and types'
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
		'Dim As Zstring * 32 duplicateVar = "   N.Child.duplicateVar"
	End Type
	Type GrandChild Extends Child
		'Dim As Zstring * 32 duplicateVar = "   N.GrandChild.duplicateVar"
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

gc.test()                '' "N.Parent.duplicateVar" expected : in [2] base types (by 'Extends')
Print gc.duplicateVar    '' "N.Parent.duplicateVar" expected : in [2] base types (by 'Extends')

Print
Sleep
