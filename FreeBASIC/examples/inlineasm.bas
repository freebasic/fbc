
declare function mulintegers( byval x as integer, byval y as integer ) as integer

	randomize timer
	a = rnd * 100
	b = rnd * 100

	print a; " * "; b; " = "; mulintegers( a, b )
	
	sleep
	

'':::::
function mulintegers( byval x as integer, byval y as integer ) as integer
	dim res as integer
	
	asm 
		mov		eax, dword ptr [x]
		imul	eax, dword ptr [y]
		mov		dword ptr [res], eax
	end asm
	
	mulintegers = res
	
end function
	