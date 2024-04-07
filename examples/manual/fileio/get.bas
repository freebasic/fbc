'' examples/manual/fileio/get.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GET (File I/O)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetfileio
'' --------

Dim Shared f As Integer

Sub get_long()

	Dim buffer As Long ' Long variable

	' Read a Long (4 bytes) from the file into buffer, using file number "f".
	Get #f, , buffer

	' print out result
	Print buffer
	Print

End Sub

Sub get_array()

	Dim an_array(0 To 10-1) As Long ' array of Longs

	' Read 10 Longs (10 * 4 = 40 bytes) from the file into an_array, using file number "f".
	Get #f, , an_array()

	' print out result
	For i As Integer = 0 To 10-1
		Print an_array(i)
	Next
	Print

End Sub

Sub get_mem

	Dim pmem As Long Ptr

	' allocate memory for 5 Longs
	pmem = Allocate(5 * SizeOf(Long))

	' Read 5 Longs (5 * 4 = 20 bytes) from the file into allocated memory
	Get #f, , *pmem, 5 ' Note pmem must be dereferenced (*pmem, or pmem[0])

	' print out result using [] Pointer Indexing
	For i As Integer = 0 To 5-1
		Print pmem[i]
	Next
	Print

	' free pointer memory to prevent memory leak
	Deallocate pmem

End Sub

' Find the first free file file number.
f = FreeFile

' Open the file "file.ext" for binary usage, using the file number "f".
Open "file.ext" For Binary As #f

  get_long()

  get_array()

  get_mem()

' Close the file.  
Close #f
