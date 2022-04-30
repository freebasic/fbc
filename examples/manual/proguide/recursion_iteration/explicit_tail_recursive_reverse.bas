'' examples/manual/proguide/recursion_iteration/explicit_tail_recursive_reverse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function explicitTailRecursiveReverse (ByVal s As String, ByVal cumul As String = "") As String
	If (s = "") Then                                   '' end condition
		Return cumul
	Else                                               '' recursion loop
		cumul = Left(s, 1) & cumul
		s = Mid(s, 2)
		Return explicitTailRecursiveReverse(s, cumul)  '' tail recursive call
	End If
End Function
		
