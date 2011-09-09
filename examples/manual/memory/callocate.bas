'' examples/manual/memory/callocate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCallocate
'' --------

' Allocate and initialize space for 10 integer elements.
Dim p As Integer Ptr = CAllocate(10, SizeOf(Integer))

' Fill the memory with integer values.
For index As Integer = 0 To 9
	p[index] = (index + 1) * 10
Next

' Display the integer values.
For index As Integer = 0 To 9
	Print p[index] ;
Next

' Free the memory.
Deallocate(p)
