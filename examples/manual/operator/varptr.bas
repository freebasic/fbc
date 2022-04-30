'' examples/manual/operator/varptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator VARPTR (Variable pointer)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpVarptr
'' --------

Dim a As Integer, addr As Integer
a = 10

'' place the address of a in addr
addr = CInt( VarPtr(a) )

'' change all 4 bytes (size of INTEGER) of a
Poke Integer, addr, -1000 
Print a

'' place the address of a in addr (same as above)
addr = CInt( @a )

'' print the least or most significant byte, depending on the CPU endianess
Print Peek( addr ) 
