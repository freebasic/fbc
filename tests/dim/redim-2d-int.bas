#include "fbcunit.bi"

SUITE( fbc_tests.dim_.redim_2d_int )

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

	sub init_array_2d _
		( _
			a() as integer, _
			byval lb0 as integer, _
			byval ub0 as integer, _
			byval lb1 as integer, _
			byval ub1 as integer _
		)

		dim counter as integer = 1
		for idx0 as integer = lb0 to ub0
			for idx1 as integer = lb1 to ub1
				a(idx0, idx1) = counter
				counter += 1
			next
		next
	end sub

	#macro check_array( c, a )
		scope
			var lb0_c = lbound(c)
			var size_c = ubound(c) - lb0_c + 1

			var lb0_a = lbound(a,1)
			var size0_a = ubound(a,1) - lb0_a + 1

			var lb1_a = lbound(a,2)
			var size1_a = ubound(a,2) - lb1_a + 1

			var size_a = size0_a * size1_a
			var idx = 0

			CU_ASSERT( size_c >= size_a )

			if( size_c >= size_a ) then
				for idx0 as integer = 0 to size0_a - 1
					for idx1 as integer = 0 to size1_a - 1
						CU_ASSERT_EQUAL( c(lb0_c + idx), a(lb0_a + idx0, lb1_a + idx1) )
						idx += 1
					next
				next
			end if
		end scope
	#endmacro

	TEST( shift )
		'' expected result array - zero based
		redim as integer c( 0 to 49 )
		init_array_1d( c(), 0, 49 )

		'' array to shift
		dim as integer a( )
		redim a( 0 to 9, 0 to 4 )
		init_array_2d( a(), 0, 9, 0, 4 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( 1 to 10, 1 to 5 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( -10 to -1, -5 to -1 )
		check_array( c, a )

		'' keep same number of elements but change bounds
		redim preserve a( 2 to 11, 3 to 7 )
		check_array( c, a )
	END_TEST

	TEST( grow0 )
		'' expected result array - zero based
		redim as integer c( 0 to 99 )
		init_array_1d( c(), 0, 49 )

		'' array to grow
		dim as integer a( )
		redim a( 0 to 9, 0 to 4 )
		init_array_2d( a(), 0, 9, 0, 4 )
		check_array( c, a )

		'' grow the array
		redim preserve a( 0 to 19, 0 to 4 )
		check_array( c, a )
	END_TEST

	TEST( shrink0 )
		'' expected result array - zero based
		redim as integer c( 0 to 49 )
		init_array_1d( c(), 0, 49 )

		'' array to shrink
		dim as integer a( )
		redim a( 0 to 9, 0 to 4 )
		init_array_2d( a(), 0, 9, 0, 4 )
		check_array( c, a )

		'' shrink the array
		redim preserve a( 0 to 7, 0 to 4 )
		check_array( c, a )
	END_TEST

	TEST( shift_and_grow0 )
		'' expected result array - zero based
		redim as integer c( 0 to 99 )
		init_array_1d( c(), 0, 49 )

		'' array to shift and grow
		dim as integer a( )
		redim a( 0 to 9, 0 to 4 )
		init_array_2d( a(), 0, 9, 0, 4 )
		check_array( c, a )

		'' grow and shift the array
		redim preserve a( 5 to 24, 3 to 7 )
		check_array( c, a )
	END_TEST

	TEST( shift_and_shrink0 )
		'' expected result array - zero based
		redim as integer c( 0 to 49 )
		init_array_1d( c(), 0, 49 )

		'' array to shift and shrink
		dim as integer a( )
		redim a( 0 to 9, 0 to 4 )
		init_array_2d( a(), 0, 9, 0, 4 )
		check_array( c, a )

		'' shrink and shift one of the arrays
		redim preserve a( 5 to 9, 3 to 7 )
		check_array( c, a )
	END_TEST

	TEST( grow1 )
		'' expected result array - zero based
		redim as integer c( 0 to 99 )
		init_array_1d( c(), 0, 49 )

		'' array to grow
		dim as integer a( )
		redim a( 0 to 4, 0 to 9 )
		init_array_2d( a(), 0, 4, 0, 9 )
		check_array( c, a )

		'' grow the array
		redim preserve a( 0 to 4, 0 to 19 )
		check_array( c, a )
	END_TEST

	TEST( shrink1 )
		'' expected result array - zero based
		redim as integer c( 0 to 49 )
		init_array_1d( c(), 0, 49 )

		'' array to shrink
		dim as integer a( )
		redim a( 0 to 4, 0 to 9 )
		init_array_2d( a(), 0, 4, 0, 9 )
		check_array( c, a )

		'' shrink the array
		redim preserve a( 0 to 4, 0 to 7 )
		check_array( c, a )
	END_TEST

	TEST( shift_and_grow1 )
		'' expected result array - zero based
		redim as integer c( 0 to 99 )
		init_array_1d( c(), 0, 49 )

		'' array to shift and grow
		dim as integer a( )
		redim a( 0 to 4, 0 to 9 )
		init_array_2d( a(), 0, 4, 0, 9 )
		check_array( c, a )

		'' grow and shift the array
		redim preserve a( 3 to 7, 5 to 24 )
		check_array( c, a )
	END_TEST

	TEST( shift_and_shrink1 )
		'' expected result array - zero based
		redim as integer c( 0 to 49 )
		init_array_1d( c(), 0, 49 )

		'' array to shift and shrink
		dim as integer a( )
		redim a( 0 to 4, 0 to 9 )
		init_array_2d( a(), 0, 4, 0, 9 )
		check_array( c, a )

		'' shrink and shift one of the arrays
		redim preserve a( 3 to 7, 5 to 9 )
		check_array( c, a )
	END_TEST
END_SUITE
