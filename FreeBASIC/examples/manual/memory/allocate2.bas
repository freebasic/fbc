'' examples/manual/memory/allocate2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAllocate
'' --------

Sub AllocateExample2()
   Dim p As Byte Ptr = 0

   p = Allocate(420)               '' assign pointer to new memory

   p = Allocate(420)               '' reassign pointer to different memory,
	                               '' old address is lost and that memory is leaked
   Deallocate(p)
End Sub

   AllocateExample2()
   End 0
