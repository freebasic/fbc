''
'' inline assembly example
''

declare function mulintegers( byval x as integer, byval y as integer ) as integer

	randomize timer
	dim as integer a = rnd * 100
	dim as integer b = rnd * 100

	print a; " * "; b; " = "; mulintegers( a, b )
	
	sleep
	

'':::::
function mulintegers( byval x as integer, byval y as integer ) as integer
	
	asm 
		mov		eax, [x]
		imul	eax, [y]
		mov		[function], eax
	end asm
	
end function
	