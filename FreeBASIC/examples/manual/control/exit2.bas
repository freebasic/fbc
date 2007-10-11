'' examples/manual/control/exit2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExit
'' --------

Dim As Integer i, j
For i = 1 To 10
	
	For j = 1 To 10
	    
	    Exit For, For
	    
	Next j
	
	Print "I will never be shown"
	
Next i
