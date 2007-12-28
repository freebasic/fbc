'' examples/manual/misc/asm.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAsm
'' --------

'' This is an example for the x86 architecture.
Function AddFive(ByVal num As Integer) As Integer
	Asm
		mov eax, [num]
		add eax, 5
		mov [Function], eax
	End Asm
End Function

Dim i As Integer = 4

Print "4 + 5 ="; AddFive(i)
