'' examples/manual/math/log.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LOG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLog
'' --------

'Find the logarithm of any base
Function LogBaseX (ByVal Number As Double, ByVal BaseX As Double) As Double
	LogBaseX = Log( Number ) / Log( BaseX )
	'For reference:   1/log(10)=0.43429448
End Function

Print "The log base 10 of 20 is:"; LogBaseX ( 20 , 10 )
Print "The log base 2 of 16 is:"; LogBaseX ( 16 , 2 )

Sleep
