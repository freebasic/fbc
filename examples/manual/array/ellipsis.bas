'' examples/manual/array/ellipsis.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '... (Ellipsis)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDots
'' --------

Dim As Integer myarray(0 To ...) = {0, 1, 2, 3}
Print LBound(myarray), UBound(myarray)   '' 0, 3
