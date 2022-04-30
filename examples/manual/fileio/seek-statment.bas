'' examples/manual/fileio/seek-statment.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SEEK (Statement)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSeekset
'' --------

' e.g. if you want to skip to the 100th byte in the file for reading/writing:

Dim f As Long

f = FreeFile
Open "file.ext" For Binary As #f

Seek f, 100

Close #f
