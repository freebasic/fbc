'' examples/manual/fileio/put.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPutfileio
'' --------

' Create a integer variable
Dim buffer As Integer, f As Integer

' Find the first free file file number.
f = FreeFile

' Open the file "file.ext" for binary usage, using the file number "f".
Open "file.ext" For Binary As #f
  buffer=10
  ' Write 4 bytes from the buffer into the file, using file number "f"
  ' starting at the beginning of the file (1).
  Put #f, 1, buffer

' Close the file.  
Close #f

' End the program.
End
