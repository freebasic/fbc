'' examples/manual/proguide/callback/callback_qsort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Callback'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCallback
'' --------

#include "crt/stdlib.bi"

Function CmpVarLenStr cdecl( ByVal p1 As Any Ptr, ByVal p2 As Any Ptr ) As Long  '' compare 2 var-len strings
	Dim As String Ptr ps1 = p1
	Dim As String Ptr ps2 = p2
	If *ps1 < *ps2 Then
		Return -1
	ElseIf *ps1 > *ps2 Then
		Return 1
	Else
		Return 0
	End If
End Function

Sub PrintList( array() As String)  '' print a var-len string list
	For I As Integer = LBound(array) To UBound(array)
		Print array(I)
	Next I
	Print
End Sub

Dim forename(1 To 12) As String = {"Madison", "Emily", "Hailey", "Sarah", "Kaitlyn", "Hannah", _
								   "Jacob", "Christopher", "Nicholas", "Michael", "Matthew", "Joshua" }

Print "LIST OF UNSORTED FORENAMES:"
PrintList( forename() )

qsort( @forename(LBound(forename)), UBound(forename) - LBound(forename) + 1, SizeOf(String), @CmpVarLenStr )

Print "LIST OF SORTED FORENAMES:"
PrintList( forename() )

Sleep
		
