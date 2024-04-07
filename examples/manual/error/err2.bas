'' examples/manual/error/err2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ERR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErr
'' --------

'' compile without -e switch

Dim filename As String

Do
	Line Input "Input filename: ", filename
	If filename = "" Then End
	Open filename For Input As #1
Loop Until Err() = 0

Print Using "File '&' opened successfully"; filename
Close #1
