'' examples/manual/error/err2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErr
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
