
'':::::
sub varstrings cdecl ( byval n as integer, ... )
	dim va as any ptr
	
	va = va_first( )
	
	for i = 1 to n
		print *va_arg( va, zstring ptr ); " ";
		va = va_next( va, zstring ptr )
	next i
	print
	
end sub


''::::
sub vastrings_test( byval a as string )
	dim s as string
	dim f as string * 3
	dim z as zstring * 3+1
	dim p1 as zstring ptr, p2 as zstring ptr
	
	s = "efg"	
	f = "ghi"	
	z = "ijk"	
	p1 = strptr( "mno" )
	p2 = strptr( "opq" )
		
	varstrings 8, "abc", "cde", s, f, z, a, p1, *p2
	
end sub	


	vastrings_test "klm"
	
	sleep