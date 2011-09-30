'' examples/manual/check/KeyPgDim_2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDim
'' --------

'' Compile with -lang qb

'$lang: "qb"

'' All variables beginning with A through N default to the INTEGER data type
'' All other variables will default to the SINGLE data type
DefInt I-N

'' I and J are INTEGERs
'' X and Y are SINGLEs
'' T$ is STRING
'' D is DOUBLE

Dim I, J, X, Y, T$, D As Double
