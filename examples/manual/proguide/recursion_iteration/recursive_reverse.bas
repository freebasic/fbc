'' examples/manual/proguide/recursion_iteration/recursive_reverse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function recursiveReverse (ByVal s As String) As String
	If (s = "") Then                                     '' end condition
		Return s
	Else                                                 '' recursion loop
		Return recursiveReverse(Mid(s, 2)) & Left(s, 1)  '' recursive call
	End If
End Function
		
