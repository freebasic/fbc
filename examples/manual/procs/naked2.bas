'' examples/manual/procs/naked2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'NAKED'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNaked
'' --------

'' Naked cdecl function (for fbc 32-bit)
'' plus ecx register preserved in asm block by creating user stack
Function subtract_cp Naked cdecl _      '' parameters pushed onto call stack in reverse order of declaration
	( _
		ByVal a As Long, _
		ByVal b As Long _            '' parameter pushed onto stack in first
	) As Long
   
	Asm
		push ebp                        '' push ebp onto stack   => esp -= 4
		mov ebp, esp                    '' ebp = esp
										''    => create user stack 4 bytes above call stack
		push ecx                        '' push ecx onto user stack   => esp -= 4
		mov eax, dword Ptr [(ebp+4)+4]  '' eax = a   (supplementary offset of +4 bytes only due to 'push ebp')
		mov ecx, dword Ptr [(ebp+8)+4]  '' ecx = b   (supplementary offset of +4 bytes only due to 'push ebp')
		Sub eax, ecx                    '' eax -= ecx
		pop ecx                         '' pop ecx from user stack   => esp += 4
		mov esp, ebp                    '' esp = ebp
		pop ebp                         '' pop ebp from stack   => esp += 4
										''    => discard user stack
		ret                             '' return result in eax
	End Asm
   
End Function

Print subtract_cp( 5, 1 ) '' 5 - 1
