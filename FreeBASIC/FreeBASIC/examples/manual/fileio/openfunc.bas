'' examples/manual/fileio/openfunc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpen
'' --------

Dim openerror As Integer

openerror = Open("file.ext" For Binary Access Read As #1)

If openerror Then
	Print "Error opening file: " & openerror
End If
