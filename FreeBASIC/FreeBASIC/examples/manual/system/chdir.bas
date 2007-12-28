'' examples/manual/system/chdir.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChdir
'' --------

Dim pathname As String = "x:\folder"
Dim result As Integer = ChDir(pathname)

If 0 <> result Then Print "error changing current directory to " & pathname & "."
