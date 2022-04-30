'' examples/manual/memory/reallocate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'REALLOCATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReallocate
'' --------

Dim a As Integer Ptr, b As Integer Ptr, i As Integer

a = Allocate( 5 * SizeOf(Integer) )   ' Allocate memory for 5 integers

If a = 0 Then Print "Error Allocating a": End

For i = 0 To 4
  a[i] = (i + 1) * 2   ' Assign integers to the buffer
Next i

b = Reallocate( a, 10 * SizeOf(Integer) )   ' Reallocate memory for 5 additional integers

If b <> 0 Then

	a = b   ' Discard the old pointer and use the new one

	For i = 5 To 9
	  a[i] = (i + 1) * 2   ' Assign more integers to the buffer
	Next i

	For i = 0 To 9   ' Print the integers
	  Print i, a[i]
	Next i
	Print

Else '' Reallocate failed, memory unchanged

	Print "Error Reallocating a"

	For i = 0 To 4   ' Print the integers
	  Print i, a[i]
	Next i
	Print

End If

Deallocate a   ' Clean up
	
