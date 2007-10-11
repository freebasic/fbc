'' examples/manual/proguide/procptrs/procptrs.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

Sub Halve (ByRef i As Integer)
	i /= 2
End Sub

Sub Triple (ByRef i As Integer)
	i *= 3
End Sub

Type operation As Sub (ByRef As Integer)

' an array of procedure pointers, NULL indicates the
' end of the array
Dim operations(20) As operation = _
{ @Halve, @Triple, 0 }

Dim i As Integer = 280

' apply all of the operations to a variable by iterating through the array
' with a pointer to procedure pointer
Dim op As operation Ptr = @operations(0)
While (0 <> *op)
	' call the procedure that is pointed to, note the extra parenthesis
	(*op)(i)
	op += 1
Wend

Print "Value of 'i' after all operations performed: " & i
