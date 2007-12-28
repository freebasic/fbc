'' examples/manual/fileio/get.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetfileio
'' --------

Dim buffer As Integer
Dim an_array(0 To 9) As Integer
Dim pmem As Integer Ptr
Dim f As Integer

Dim x As Integer

' Find the first free file file number.
f = FreeFile

' Open the file "file.ext" for binary usage, using the file number "f".
Open "file.ext" For Binary As #f

' Read 4 bytes from the file into buffer, using file number "f".
Get #f, , buffer

' print out result
Print buffer

' Read 40 (10 * 4) bytes from the file into an_array, using file number "f".
Get #f, , an_array()

' print out result
For x = 0 To 9
	Print an_array(x)
Next

' allocate memory for 5 integers
pmem = Allocate(5 * SizeOf(Integer))
' Read 5 integers from the file into allocated memory
Get #f,, *pmem, 5    ' Note pmem must be dereferenced (*pmem)

' print out result using [] Pointer Indexing or pointer arithmic 
For x = 0 To 4
	Print pmem[x] ; *(pmem + x)
Next

' Close the file.  
Close #f
End
