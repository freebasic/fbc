'' examples/manual/prepro/assert.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpassert
'' --------

Const MIN = 5, MAX = 10
#assert MAX > MIN '' cause an error if MAX <= MIN
