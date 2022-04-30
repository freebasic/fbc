'' examples/manual/proguide/procptrs/procptrs.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

Function Halve (ByVal i As Integer) As Integer
	Return i / 2
End Function

Function Triple (ByVal i As Integer) As Integer
	Return i * 3
End Function

Type operation As Function (ByVal As Integer) As Integer

' an array of procedure pointers, NULL indicates the
' end of the array
Dim operations(20) As operation = _
{ @Halve, @Triple, 0 }

Dim i As Integer = 280

' apply all of the operations to a variable by iterating through the array
' with a pointer to procedure pointer
Dim op As operation Ptr = @operations(0)
While (*op <> 0)
	' call the procedure that is pointed to, note the extra parenthesis
	i = (*op)(i)
	op += 1
Wend

Print "Value of 'i' after all operations performed: " & i
		
