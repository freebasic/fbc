'' examples/manual/system/chdir.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CHDIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChdir
'' --------

Dim pathname As String = $"x:\folder"
Dim result As Long = ChDir(pathname)

If result <> 0 Then Print "error changing current directory to " & pathname & "."
