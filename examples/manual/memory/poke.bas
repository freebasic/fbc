'' examples/manual/memory/poke.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'POKE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPoke
'' --------

Dim i As Integer, p As Integer Ptr
p = @i

Poke Integer, p, 420
Print Peek(Integer, p)
