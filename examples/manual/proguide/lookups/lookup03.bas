'' examples/manual/proguide/lookups/lookup03.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Identifier Look-ups in namespaces and types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgIdentifierLookup
'' --------

Sub duplicateSub()
	Print "   ..duplicateSub"
End Sub

Namespace M
	Sub duplicateSub()
		Print "   M.duplicateSub"
	End Sub
End Namespace

Namespace N
	'Sub duplicateSub()
	'    Print "   N.duplicateSub"
	'End Sub
	Namespace P
		Using M
		'Sub duplicateSub()
		'    Print "   N.P.duplicateSub"
		'End Sub
		Sub test()
			Using M  '' useless, but just to demonstrate that does not increase priority level of imported namespace 
			duplicateSub()
		End Sub
	End Namespace
End Namespace

Print "From Namespace:"
' "N.P.test()" calls the unqualified identifier "duplicateSub"
' "N.P.duplicateSub()" calls the qualified identifier "N.P.duplicateSub"

N.P.test()               '' "..duplicateSub" expected : in [3] parent namespaces (by nesting)
N.P.duplicateSub()       '' "M.duplicateSub" expected : in [4] imported namespaces (by 'Using')

Print
Sleep
