'' examples/manual/proguide/pointers/distance.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointer Arithmetic'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPtrArithmetic
'' --------

Type T As Single

Dim array(5) As T = { 32, 43, 66, 348, 112, 0 }
Dim p As T Ptr = @array(0)

While (*p <> 0)
	p += 1
Wend
Print p - @array(0)
