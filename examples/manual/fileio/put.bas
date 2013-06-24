'' examples/manual/fileio/put.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPutfileio
'' --------

' Create variables for the file number, and the number to put
Dim As Integer f
Dim As Long value

' Find the first free file number
f = FreeFile()

' Open the file "file.ext" for binary usage, using the file number "f"
Open "file.ext" For Binary As #f

  value= 10

  ' Write the bytes of the integer 'value' into the file, using file number "f"
  ' starting at the beginning of the file (position 1)
  Put #f, 1, value

' Close the file
Close #f
