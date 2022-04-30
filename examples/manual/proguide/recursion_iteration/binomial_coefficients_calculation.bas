'' examples/manual/proguide/recursion_iteration/binomial_coefficients_calculation.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function recursiveCombination (ByVal n As UInteger, ByVal p As UInteger) As LongInt
	If p = 0 Or p = n Then
		Return 1
	Else
		Return recursiveCombination(n - 1, p) + recursiveCombination(n - 1, p - 1)
	End If
End Function

'---------------------------------------------------------------------------

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForUinteger, UInteger)

Function translationToIterativeCombinationStack (ByVal n As UInteger, ByVal p As UInteger) As LongInt
	Dim cumul As LongInt = 0
	Dim As DynamicUserStackTypeForUinteger S
	S.push = n : S.push = p
	While S.used > 0
		p = S.pop : n = S.pop
		If p = 0 Or p = n Then
			cumul = cumul + 1
		Else
			S.push = n - 1 : S.push = p
			S.push = n - 1 : S.push = p - 1
		End If
	Wend
	Return cumul
End Function

'---------------------------------------------------------------------------

Sub Display(ByVal Combination As Function (ByVal n As UInteger, ByVal p As UInteger) As LongInt, ByVal n As Integer)
	For I As UInteger = 0 To n
		For J As UInteger = 0 To I
			Locate , 6 * J + 3 * (n - I) + 3
			Print Combination(I, J);
		Next J
		Print
	Next I
End Sub

'---------------------------------------------------------------------------

Print " recursion:";
Display(@recursiveCombination, 12)

Print
Print
Print " iteration with own storage stack:";
Display(@translationToIterativeCombinationStack, 12)

Sleep
			
