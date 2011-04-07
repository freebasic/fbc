'' examples/manual/fileio/put-array.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPutfileio
'' --------

' Create an integer array
Dim buffer(1 To 10) As Integer
Dim i As Integer
For i = 1 To 10
	buffer(i) = i
Next

' Find the first free file file number.
Dim f As Integer
f = FreeFile

' Open the file "file.ext" for binary usage, using the file number "f".
Open "file.ext" For Binary As #f
' Write the array into the file, using file number "f"
' starting at the beginning of the file (1).
Put #f, 1, buffer()

' Close the file.
Close #f

' End the program.
End
