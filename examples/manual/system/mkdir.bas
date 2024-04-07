'' examples/manual/system/mkdir.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MKDIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkdir
'' --------

Dim pathname As String = "foo\bar\baz"
Dim result As Long = MkDir( pathname )

If 0 <> result Then Print "error: unable to create folder " & pathname & " in the current path."
