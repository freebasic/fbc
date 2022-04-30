'' examples/manual/proguide/errors/on-error.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Error Handling'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

'' Compile with QB (-lang qb) dialect

'$lang: "qb"

On Error Goto FAILED
Open "xzxwz.zwz" For Input As #1
On Error Goto 0
Sleep
End

FAILED:
Dim e As Integer
e = Err
Print e
Sleep
End
	
