'' examples/manual/proguide/references/with-pointer1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Function maxPtr (ByVal p1 As Integer Ptr, ByVal p2 As Integer Ptr) As Integer Ptr
	If *p1 > *p2 Then
		Return p1
	Else
		Return p2
	End If
End Function

Dim As Integer i1 = 1, i2 = 2
Print i1, i2
*maxPtr(@i1, @i2) = 3
Print i1, i2

Sleep
			
