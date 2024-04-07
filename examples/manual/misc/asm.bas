'' examples/manual/misc/asm.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ASM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAsm
'' --------

'' This is an example for the x86 architecture.
Function AddFive(ByVal num As Long) As Long
	Asm
		mov eax, [num]
		Add eax, 5
		mov [Function], eax
	End Asm
End Function

Dim i As Long = 4

Print "4 + 5 ="; AddFive(i)
