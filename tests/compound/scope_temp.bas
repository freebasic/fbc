# include "fbcunit.bi"

SUITE( fbc_tests.compound.scope_temp )

	type vector
	  as integer x, y, z
	end type

	function proc( ) as vector
		function = type( 7, 8, 9 )
	end function

	TEST( test_temp )

		dim as vector v = type( -1, -2, -3 )
		
		scope
			dim a as vector = type( 1, 2, 3 )
		   dim b as vector = type( 4, 5, 6 )
		   dim c as vector = proc( )

			CU_ASSERT( a.x = 1 and a.y = 2 and a.z = 3 )
			CU_ASSERT( b.x = 4 and b.y = 5 and b.z = 6 )
			CU_ASSERT( c.x = 7 and c.y = 8 and c.z = 9 )
		end scope
		
		CU_ASSERT( v.x = -1 and v.y = -2 and v.z = -3 )

	END_TEST

END_SUITE
