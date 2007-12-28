'' examples/manual/fileio/binary-write.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBinary
'' --------

'' Create a binary data file with one number in it
Dim x As Single = 17.164

Open "MyFile.Dat" For Binary As #1
  '' put without a position setting will put from the last known file position
  '' in this case, the very beginning of the file.
  Put #1, , x
Close #1
