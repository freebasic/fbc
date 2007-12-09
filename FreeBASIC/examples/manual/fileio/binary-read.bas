'' examples/manual/fileio/binary-read.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBinary
'' --------

'' Now read the number from the file
Dim x As Single = 0

Open "MyFile.Dat" For Binary As #1
  Get #1, , x
Close #1

Print x
