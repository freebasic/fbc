'' examples/manual/prepro/assert.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ASSERT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpassert
'' --------

Const MIN = 5, MAX = 10
#assert MAX > MIN '' cause a compile-time error if MAX <= MIN
