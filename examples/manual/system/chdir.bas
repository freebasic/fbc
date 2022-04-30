'' examples/manual/system/chdir.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChdir
'' --------

Dim pathname As String = $"x:\folder"
Dim result As Long = ChDir(pathname)

If result <> 0 Then Print "error changing current directory to " & pathname & "."
