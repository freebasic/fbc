'' examples/manual/proguide/pointers/incdec.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPtrArithmetic
'' --------

Dim array(5) As Short = { 32, 43, 66, 348, 112, 0 }
Dim p As Short Ptr = @array(0)

While (*p <> 0)
	If (*p = 66) Then Print "found 66"
	p += 1
Wend
