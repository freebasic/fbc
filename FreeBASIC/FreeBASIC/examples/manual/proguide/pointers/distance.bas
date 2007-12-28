'' examples/manual/proguide/pointers/distance.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPtrArithmetic
'' --------

Type T As Single

Dim array(5) As T = { 32, 43, 66, 348, 112, 0 }
Dim p As T Ptr = @array(0)

While (*p <> 0)
	p += 1
Wend
Print p - @array(0)
