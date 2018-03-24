# include "fbcunit.bi"

SUITE( fbc_tests.functions.return_notreg2 )
	
	type foo
		x(63) as integer
	end type
	
	function heh( ) as foo
		if( 0 = 1 ) then
			function = type({type(1)})
		end if
	end function
	
	TEST( testproc )
		dim as foo thing
		thing = heh( )
		for i as integer = 0 to 63
			CU_ASSERT( thing.x(i) = 0 )
		next
	END_TEST
	
END_SUITE
