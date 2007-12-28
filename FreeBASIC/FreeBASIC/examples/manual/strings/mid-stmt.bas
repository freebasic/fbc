'' examples/manual/strings/mid-stmt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMidstatement
'' --------

Dim text As String

text = "abc 123"
Print text 'displays "abc 123"

' replace part of text with another string
Mid(text, 5, 3) = "456" 
Print text 'displays "abc 456"
