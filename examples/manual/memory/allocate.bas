'' examples/manual/memory/allocate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ALLOCATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAllocate
'' --------

'' This program uses the ALLOCATE(...) function to create a buffer of 15 integers that is
'' then filled with the first 15 numbers of the Fibonacci Sequence, then output to the
'' screen. Note the call to DEALLOCATE(...) at the end of the program.

	Const integerCount As Integer = 15

	'' Try allocating memory for a number of integers.
	''
	Dim buffer As Integer Ptr
	buffer = Allocate(integerCount * SizeOf(Integer))

	If (0 = buffer) Then
		Print "Error: unable to allocate memory, quitting."
		End -1
	End If

	'' Prime and fill the memory with the fibonacci sequence.
	''
	buffer[0] = 0
	buffer[1] = 1
	For i As Integer = 2 To integerCount - 1
		buffer[i] = buffer[i - 1] + buffer[i - 2]
	Next

	'' Display the sequence.
	''
	For i As Integer = 0 To integerCount - 1
		Print buffer[i] ;
	Next

	Deallocate(buffer)
	End 0
