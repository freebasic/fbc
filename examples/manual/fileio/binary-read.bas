'' examples/manual/fileio/binary-read.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BINARY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBinary
'' --------

'' Now read the number from the file
Dim x As Single = 0

Open "MyFile.Dat" For Binary As #1
  Get #1, , x
Close #1

Print x
