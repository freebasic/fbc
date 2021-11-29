#include "fbcunit.bi"

SUITE( fbc_tests.dim_.redim_1d_int )

	sub init_array_1d _
		( _
			a() as integer, _
			byval lb0 as integer, _
			byval ub0 as integer _
		)

		dim counter as integer = 1
		for idx0 as integer = lb0 to ub0
			a(idx0) = counter
			counter += 1
		next
	end sub

	#macro check_array( c, a )
		scope
			var lb0_c = lbound(c)
			var size_c = ubound(c) - lb0_c + 1

			var lb0_a = lbound(a)
			var size_a = ubound(a) - lb0_a + 1

			CU_ASSERT( size_c >= size_a )

			if( size_c >= size_a ) then
				for idx0 as integer = 0 to size_a - 1
					CU_ASSERT_EQUAL( c(lb0_c + idx0), a(lb0_a + idx0) )
				next
			end if
		end scope
	#endmacro

	TEST( shift )
		'' expected result array - zero based
		redim as integer c( 0 to 9 )
		init_array_1d( c(), 0, 9 )

		'' array to resize
		dim as integer a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( 1 to 10 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( -10 to -1 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( 2 to 11 )
		check_array( c, a )
	END_TEST

	TEST( grow )
		'' expected result array - zero based
		redim as integer c( 0 to 19 )
		init_array_1d( c(), 0, 9 )

		'' array to resize
		dim as integer a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		'' grow the array
		redim preserve a( 0 to 19 )
		check_array( c, a )
	END_TEST

	TEST( shrink )
		'' expected result array - zero based
		redim as integer c( 0 to 9 )
		init_array_1d( c(), 0, 9 )

		'' array to resize
		dim as integer a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		'' shrink the arrays
		redim preserve a( 0 to 4 )

		check_array( c, a )
	END_TEST

	TEST( shift_and_grow )
		'' expected result array - zero based
		dim as integer c( 0 to 19 )
		init_array_1d( c(), 0, 9 )

		'' array to resize and shift
		dim as integer a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		'' grow and shift the arrays
		redim preserve a( 5 to 24 )

		check_array( c, a )
	END_TEST

	TEST( shift_and_shrink )
		'' expected result array - zero based
		dim as integer c( 0 to 19 )
		init_array_1d( c(), 0, 19 )

		dim as integer a( ) '' array to resize
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		'' shrink and shift the arrays
		redim preserve a( 5 to 9 )

		check_array( c, a )
	END_TEST

END_SUITE
