'' examples/manual/proguide/arrays/array5.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

#macro PRINT_ARRAY_SIZING (array)
	If UBound( array , 0 ) = 0 Then
		Print "'" & #array & "' un-sized"
	Else
		Print "'" & #array & "' sized with " & UBound( array , 0 ) & " dimension";
		If UBound( array , 0 ) > 1 Then
			Print "s";
		End If
		Print
		For I As Integer = 1 To UBound( array , 0 )
			Print "   dimension nb: " & I
			Print "      lower bound: " & LBound( array , I )
			Print "      upper bound: " & UBound( array , I )
		Next I
	End If
#endmacro

Dim As Integer array1( )
PRINT_ARRAY_SIZING( array1 )
Print

Dim As Single array2( Any )
PRINT_ARRAY_SIZING( array2 )
Print

Dim As String array3( 4 , 5 To 9 )
PRINT_ARRAY_SIZING( array3 )
Print

Type UDT
	Dim As Double array4( Any, Any, Any )
End Type

Dim As UDT u
PRINT_ARRAY_SIZING( u.array4 )
Print

ReDim u.array4( -7 To -3, -2 To 5, 6 To 9 )
PRINT_ARRAY_SIZING( u.array4 )
Print

Erase u.array4
PRINT_ARRAY_SIZING( u.array4 )
Print

Sleep
			
