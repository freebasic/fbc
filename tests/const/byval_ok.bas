# include "fbcunit.bi"

SUITE( fbc_tests.const_.byval_ok )
		
	type vec
		as integer x, y, z
	end type
	
	sub b( byval x as vec )
		cu_assert( x.x = 1 )
		cu_assert( x.y = 2 )
		cu_assert( x.z = 3 )
	end sub
	
	TEST( const_to_byval )
		dim as const vec foo = (1, 2, 3)
		b( foo )
	END_TEST
	
END_SUITE
