'' examples/manual/system/mkdir.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkdir
'' --------

Dim pathname As String = "foo\bar\baz"
Dim result As Integer = MkDir( pathname )

If 0 <> result Then Print "error: unable to create folder " & pathname & " in the current path."
