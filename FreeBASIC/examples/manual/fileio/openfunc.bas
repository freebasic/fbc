'' examples/manual/fileio/openfunc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpen
'' --------

'function version of OPEN
If Open("file.ext" For Binary Access Read As #1) = 0 Then

	Print "Successfully opened file"

	'' ...

	Close #1

Else

	Print "Error opening file"

End If
