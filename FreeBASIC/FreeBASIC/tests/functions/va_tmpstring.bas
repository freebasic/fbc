# include "fbcu.bi"




namespace fbc_tests.functions.va_tempstring

	dim shared strtb(1 to 2) as zstring * 6+1 => { "ABCdef", "defABC" }
		
'':::::
function toupperz( byval s as string ) as string

	return ucase( s )

end function

'':::::
function tolowerz( byval s as string ) as string

	return lcase( s )

end function

'':::::
function concatz( byval s1 as string, byval s2 as string ) as string

	return s1 + s2

end function

'':::::
sub printstrings cdecl ( byval cnt as integer, ... )
	dim va as any ptr
	dim i as integer
	
	va = va_first( )
	
	for i = 1 to cnt
		CU_ASSERT( *va_arg( va, zstring ptr ) = strtb(i) )
		va = va_next( va, zstring ptr )
	next

end sub
	
sub test_1 cdecl ()

	dim s as string
	dim z as zstring * 3+1
	
	s = "AbC"
	z = "dEf"
	
	printstrings 2, concatz( toupperz( s ), tolowerz( z ) ), concatz( tolowerz( z ), toupperz( s ) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.va_tempstring")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
