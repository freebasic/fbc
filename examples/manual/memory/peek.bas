'' examples/manual/memory/peek.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PEEK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPeek
'' --------

Dim i As Integer, p As Integer Ptr
p = @i

Poke Integer, p, 420
Print Peek(Integer, p)
