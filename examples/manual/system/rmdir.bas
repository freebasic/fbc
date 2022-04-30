'' examples/manual/system/rmdir.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RMDIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRmdir
'' --------

Dim pathname As String = "foo\bar\baz"
Dim result As Integer = RmDir( pathname )

If 0 <> result Then Print "error: unable to remove folder " & pathname & " in the current path."
