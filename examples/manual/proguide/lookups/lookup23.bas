'' examples/manual/proguide/lookups/lookup23.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Identifier Look-ups in namespaces and types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgIdentifierLookup
'' --------

Type duplicateType
	Dim As ZString * 32 root = "   ..duplicateType"
End Type

Namespace M
	Type duplicateType
		Dim As ZString * 32 root = "   M.duplicateType"
	End Type
End Namespace

Namespace N
	'Type duplicateType
	'    Dim As Zstring * 32 root = "   N.duplicateType"
	'End type
	Namespace P
		Using M
		'Type duplicateType
		'    Dim As Zstring * 32 root = "   N.P.duplicateType"
		'End type
		Sub test()
			Using M  '' useless, but just to demonstrate that does not increase priority level of imported namespace
			Print Type<duplicateType>.root
		End Sub
	End Namespace
End Namespace

' "N.P.test()" calls the unqualified identifier "duplicateType"
' "Print Type<N.P.duplicateType>.root" calls the qualified identifier "N.P.duplicateType"

Print "From Namespace:"
N.P.test()                          '' "..duplicateSub" expected : in [3] parent namespaces (by nesting)
Print Type<N.P.duplicateType>.root  '' "M.duplicateSub" expected : in [4] imported namespaces (by 'Using')

Print
Sleep
