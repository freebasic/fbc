'' examples/manual/control/iif3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IIF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIif
'' --------

Dim As Integer I
I = -10
Print I, IIf(I>0, "positive", IIf(I=0, "null", "negative"))
I = 0
Print I, IIf(I>0, "positive", IIf(I=0, "null", "negative"))
I = 10
Print I, IIf(I>0, "positive", IIf(I=0, "null", "negative"))
Sleep
