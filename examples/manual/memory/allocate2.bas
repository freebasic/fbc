'' examples/manual/memory/allocate2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAllocate
'' --------

'' Bad example of Allocate usage, causing memory leaks

Sub BadAllocateExample()

	Dim p As Byte Ptr

	p = Allocate(420)   '' assign pointer to new memory

	p = Allocate(420)   '' reassign same pointer to different memory,
	                    '' old address is lost and that memory is leaked

	Deallocate(p)

End Sub

	'' Main
	BadAllocateExample() '' Creates a memory leak 
	Print "Memory leak!"
	BadAllocateExample() '' ... and another
	Print "Memory leak!"
	End
