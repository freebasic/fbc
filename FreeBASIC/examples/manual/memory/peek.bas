'' examples/manual/memory/peek.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPeek
'' --------

Dim i As Integer, p As Integer Ptr
p = @i

Poke Integer, p, 420
Print Peek(Integer, p)
