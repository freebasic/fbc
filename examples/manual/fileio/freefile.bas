'' examples/manual/fileio/freefile.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FREEFILE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFreefile
'' --------

' Create a string and fill it.
Dim buffer As String, f As Long
buffer = "Hello World within a file."

' Find the first free file number.
f = FreeFile

' Open the file "file.ext" for binary usage, using the file number "f".
Open "file.ext" For Binary As #f

' Place our string inside the file, using file number "f".
Put #f, , buffer

' Close the file.
Close #f

' End the program. (Check the file "file.ext" upon running to see the output.)
End
