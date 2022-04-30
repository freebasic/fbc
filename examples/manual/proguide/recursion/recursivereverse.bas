'' examples/manual/proguide/recursion/recursivereverse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Function recursiveReverse (ByVal s As String) As String
	If (s = "") Then                                     '' end condition
		Return s
	Else                                                 '' recursion loop
		Return recursiveReverse(Mid(s, 2)) & Left(s, 1)  '' recursive call
	End If
End Function

Print recursiveReverse("9876543210")

Sleep
