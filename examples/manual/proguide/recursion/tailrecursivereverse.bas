'' examples/manual/proguide/recursion/tailrecursivereverse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Function tailRecursiveReverse (ByVal s As String, ByVal cumul As String = "") As String
	If (s = "") Then                                                '' end condition
		Return cumul
	Else                                                            '' recursion loop
		Return tailRecursiveReverse(Mid(s, 2), Left(s, 1) & cumul)  '' tail recursive call
	End If
End Function

Print tailRecursiveReverse("9876543210")

Sleep
		
