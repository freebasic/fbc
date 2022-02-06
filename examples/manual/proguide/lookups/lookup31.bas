'' examples/manual/proguide/lookups/lookup31.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgIdentifierLookup
'' --------

Dim Shared As ZString * 32 root(...) = {"   ..duplicateEnum", "   M.duplicateEnum", "   N.duplicateEnum", "   N.P.duplicateEnum"}

Enum duplicateEnum
	nb = 0
End Enum

Namespace M
	Enum duplicateEnum
		nb = 1
	End Enum
End Namespace

Namespace N
	Enum duplicateEnum
		nb = 2
	End Enum
	Namespace P
		Using M
		Enum duplicateEnum
			nb = 3
		End Enum
		Sub test()
			Using M  '' useless, but just to demonstrate that does not increase priority level of imported namespace
			Print root(duplicateEnum.nb)
		End Sub
	End Namespace
End Namespace

' "N.P.test()" calls the unqualified identifier "duplicateEnum"
' "Print root(N.P.duplicateEnum.nb)" calls the qualified identifier "N.P.duplicateEnum"

Print "From Namespace:"
N.P.test()                        '' "N.P.duplicateEnum" expected : in (1) current namespace/type
Print root(N.P.duplicateEnum.nb)  '' "N.P.duplicateEnum" expected : in (1) current namespace/type

Print
Sleep
