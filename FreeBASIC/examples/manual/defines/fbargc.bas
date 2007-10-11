'' examples/manual/defines/fbargc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargc
'' --------

Dim i As Integer
For i = 0 To __FB_ARGC__ - 1
	    Print "arg "; i; " = '"; Command(i); "'"
Next i
