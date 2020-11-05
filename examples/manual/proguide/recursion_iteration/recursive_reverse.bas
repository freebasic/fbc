'' examples/manual/proguide/recursion_iteration/recursive_reverse.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
		
