'' examples/manual/fileio/openfunc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpen
'' --------

'function version of OPEN
If Open("file.ext" For Binary Access Read As #1) = 0 Then

	Print "Successfully opened file"

	'' ...

	Close #1

Else

	Print "Error opening file"

End If
