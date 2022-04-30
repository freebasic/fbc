'' examples/manual/defines/fbargc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARGC__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargc
'' --------

Dim i As Integer
For i = 0 To __FB_ARGC__ - 1
		Print "arg "; i; " = '"; Command(i); "'"
Next i
