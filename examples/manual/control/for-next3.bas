'' examples/manual/control/for-next3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FOR...NEXT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFornext
'' --------

For ub As UByte = 240 To 255 '' Infinite loop because the end criterion value (255+1=256) can never be reached by the UByte iterator
	Print ub
	If Inkey <> "" Then Exit For
	Sleep 10
Next ub
