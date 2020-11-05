'' examples/manual/proguide/references/with-reference1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Function maxRef (ByRef r1 As Integer, ByRef r2 As Integer) ByRef As Integer
	If r1 > r2 Then
		Return r1
	Else
		Return r2
  End If
End Function

Dim As Integer i1 = 1, i2 = 2
Print i1, i2
maxRef(i1, i2) = 3
Print i1, i2

Sleep
			
