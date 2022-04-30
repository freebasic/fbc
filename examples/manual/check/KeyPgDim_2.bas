'' examples/manual/check/KeyPgDim_2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DIM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDim
'' --------

'' Compile with -lang qb

'$lang: "qb"

'' All variables beginning with A through N will default to the INTEGER data type
'' All other variables default to the SINGLE data type
DefInt I-N

Dim I, J, X, Y, T$, D As Double
'' I and J are INTEGERs
'' X and Y are SINGLEs
'' T$ is STRING
'' D is DOUBLE
