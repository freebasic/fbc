''
'' inline assembly example
''

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
		mov		eax, [x]
		imul	eax, [y]
		mov		[res], eax
	end asm
	
	mulintegers = res
	
end function
	