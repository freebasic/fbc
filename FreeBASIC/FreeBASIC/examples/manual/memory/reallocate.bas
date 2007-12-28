'' examples/manual/memory/reallocate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReallocate
'' --------

Dim a As Integer Ptr, b As Integer Ptr, i As Integer

a = Allocate( 5 * Len(Integer) )   ' Allocate memory for 5 integers
For i = 0 To 4
  a[i] = (i + 1) * 2   ' Assign integers to the buffer
Next i

b = Reallocate( a, 10 * Len(Integer) )   ' Reallocate memory for 5 additional integers
For i = 5 To 9
  b[i] = (i + 1) * 2   ' Assign more integers to the buffer
Next i

For i = 0 To 9   ' Print the integers
  Print b[i];
Next i
Print

Deallocate b   ' Clean up
