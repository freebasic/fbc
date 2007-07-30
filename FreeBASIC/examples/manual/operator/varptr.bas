'' examples/manual/operator/varptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpVarptr
'' --------

Dim a As Integer, addr As Integer
a = 10
addr = VarPtr(a) ' place the address of a in addr
Poke Integer, addr, -1000 ' change all 4 bytes (size of INTEGER) of a
Print a
addr = @a ' place the address of a in addr (same as above)
Print Peek( addr ) 'print the least or most significant byte, depending on the CPU endianess
