'' examples/manual/procs/call-fwd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CALL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb

'$lang: "qb"

Call mysub(15, 16) '' call "mysub" before it has been declared, or even mentioned.

Sub mysub(ByRef a As Integer, ByRef b As Integer)
	
	Print a, b
	
End Sub
