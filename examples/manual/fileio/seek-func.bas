'' examples/manual/fileio/seek-func.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SEEK (Function)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSeekreturn
'' --------

Dim f As Long, position As LongInt

f = FreeFile
Open "file.ext" For Binary As #f

position = Seek(f)

Close #f
