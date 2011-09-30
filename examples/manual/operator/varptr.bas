'' examples/manual/operator/varptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpVarptr
'' --------

Dim a As Integer, addr As Integer
a = 10

'' place the address of a in addr
addr = Cint( VarPtr(a) )

'' change all 4 bytes (size of INTEGER) of a
Poke Integer, addr, -1000 
Print a

'' place the address of a in addr (same as above)
addr = Cint( @a )

'' print the least or most significant byte, depending on the CPU endianess
Print Peek( addr ) 
