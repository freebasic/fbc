'' examples/manual/system/kill.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgKill
'' --------

Dim filename As String = "file.ext"
Dim result As Integer = Kill( filename )

If result <> 0 Then Print "error trying to kill " ; filename ; " !"
