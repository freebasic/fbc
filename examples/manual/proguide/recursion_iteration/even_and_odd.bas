'' examples/manual/proguide/recursion_iteration/even_and_odd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Declare Function recursiveIsEven(ByVal n As Integer) As Boolean
Declare Function recursiveIsOdd(ByVal n As Integer) As Boolean

Function recursiveIsEven(ByVal n As Integer) As Boolean
	If n = 0 Then
		Return True
	Else
		Return recursiveIsOdd(n - 1)
	End If
End Function

Function recursiveIsOdd(ByVal n As Integer) As Boolean
	If n = 0 Then
		Return False
	Else
		Return recursiveIsEven(n - 1)
	End If
End Function

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForInteger, Integer)

Function iterativeIsEven(ByVal n As Integer) As Boolean
	Dim As Integer i = 1
	Dim As DynamicUserStackTypeForInteger S
	S.push = n : S.push = i
	While S.used > 0
		i = S.pop : n = S.pop
		If i = 1 Then
			If n = 0 Then
				Return True
			Else
				S.push = n - 1 : S.push = 2
			End If
		ElseIf i = 2 Then
			If n = 0 Then
				Return False
			Else
				S.push = n - 1 : S.push = 1
			End If
		End If
	Wend
End Function

Function iterativeIsOdd(ByVal n As Integer) As Boolean
	Dim As Integer i = 2
	Dim As DynamicUserStackTypeForInteger S
	S.push = n : S.push = i
	While S.used > 0
		i = S.pop : n = S.pop
		If i = 1 Then
			If n = 0 Then
				Return True
			Else
				S.push = n - 1 : S.push = 2
			End If
		ElseIf i = 2 Then
			If n = 0 Then
				Return False
			Else
				S.push = n - 1 : S.push = 1
			End If
		End If
	Wend
End Function



Print recursiveIsEven(16), recursiveIsOdd(16)
Print recursiveIsEven(17), recursiveIsOdd(17)
Print

Print iterativeIsEven(16), iterativeIsOdd(16)
Print iterativeIsEven(17), iterativeIsOdd(17)
Print

Sleep
				
