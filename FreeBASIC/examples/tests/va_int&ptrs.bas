
'':::::
sub varints cdecl ( byval n as integer, ... )
	dim va as any ptr
	
	va = va_first( )
	
	for i = 1 to n
		print va_arg( va, integer );
		va = va_next( va, integer )
	next i
	print
	
end sub

'':::::
sub varintptrs cdecl ( byval n as integer, ... )
	dim va as any ptr
	
	va = va_first( )
	
	for i = 1 to n
		print *va_arg( va, integer ptr );
		va = va_next( va, integer ptr )
	next i
	print
	
end sub

''::::
sub vaints_test( d as integer )
	dim as integer a, b, c
	dim as integer ptr pa, pb, pc
	dim as integer ptr ptr ppc
	
	a = 1
	b = 2
	c = 3
	
	pa = @a
	pb = @b
	pc = @c
	ppc = @pc
	
	varints 4, a, *pb, **ppc, d

	varintptrs 4, pa, pb, pc, @d
	
end sub	

	vaints_test 4
	
	sleep