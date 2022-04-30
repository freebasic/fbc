'' examples/manual/proguide/recursion_iteration/tail_recursive_reverse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function tailRecursiveReverse (ByVal s As String, ByVal cumul As String = "") As String
	If (s = "") Then                                                '' end condition
		Return cumul
	Else                                                            '' recursion loop
		Return tailRecursiveReverse(Mid(s, 2), Left(s, 1) & cumul)  '' tail recursive call
	End If
End Function
		
