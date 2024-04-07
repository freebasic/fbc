'' examples/manual/proguide/arrays/fixedlen_ellipsis_initializer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fixed-length Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgFixLenArrays
'' --------

'' Declare (with one ellipsis) an array of 2 by 5 elements followed by an initializer
Dim array(1 To 2, 1 To ...) As Integer => {{1, 2, 3, 4, 5}, {1, 2, 3, 4, 5}}
		
