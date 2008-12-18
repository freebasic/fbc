function add naked cdecl _
	( _
	byval a as integer, _
	byval b as integer _
	) as integer
	
	asm
		mov eax, dword ptr [esp+4]
		add eax, dword ptr [esp+8]
		ret
	end asm
	
end function

print add( 1, 5 )
