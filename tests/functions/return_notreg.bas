# include "fbcunit.bi"

SUITE( fbc_tests.functions.return_notreg )
	
	type foo
		x(63) as integer
		declare constructor( )
	end type
	
	function heh( ) as foo
		if( 0 = 1 ) then
			function = type()
		end if
	end function
	
	constructor foo( )
		for i as integer = 0 to 63
			x(i) = i
		next
	end constructor
	
	TEST( testproc )
		dim as foo thing
		thing = heh( )
		for i as integer = 0 to 63
			CU_ASSERT( thing.x(i) = i )
		next
	END_TEST
	
END_SUITE
