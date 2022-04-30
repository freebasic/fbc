'' examples/manual/system/kill.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'KILL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgKill
'' --------

Dim filename As String = "file.ext"
Dim result As Long = Kill( filename )

If result <> 0 Then Print "error trying to kill " ; filename ; " !"
