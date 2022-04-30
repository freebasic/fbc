'' examples/manual/fileio/binary-write.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BINARY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBinary
'' --------

'' Create a binary data file with one number in it
Dim x As Single = 17.164

Open "MyFile.Dat" For Binary As #1
  '' put without a position setting will put from the last known file position
  '' in this case, the very beginning of the file.
  Put #1, , x
Close #1
