'' examples/manual/procs/call-fwd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb

'$lang: "qb"

Call mysub(15, 16) '' call "mysub" before it has been declared, or even mentioned.

Sub mysub(ByRef a As Integer, ByRef b As Integer)
	
	Print a, b
	
End Sub
