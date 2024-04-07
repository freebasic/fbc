'' examples/manual/fileio/close.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CLOSE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgClose
'' --------

' Create a string and fill it.
Dim buffer As String, f As Integer

buffer = "Hello World within a file."

' Find the first free file number.
f = FreeFile

' Open the file "file.ext" for binary usage, using the number "f".
Open "file.ext" For Binary As #f

  ' Place our string inside the file, using number "f".
  Put #f, , buffer

' Close the file.  We could also do 'Close #f', but it's only necessary if more than one number is open.
Close

' End of program. (Check the file "file.ext" upon running to see the output.)
