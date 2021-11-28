#include "fbcunit.bi"

SUITE( fbc_tests.dim_.redim_1d_udt )

	dim shared ctor_count as integer
	dim shared dtor_count as integer

	type UDT
		number as integer
		declare constructor()
		declare destructor()
	end type

	constructor UDT()
		number = 0
		ctor_count += 1
	end constructor

	destructor UDT( )
		dtor_count += 1
	end destructor
	
	sub init_array_1d _
		( _
			a() as UDT, _
			byval lb0 as integer, _
			byval ub0 as integer _
		)

		dim counter as integer = 1
		for idx0 as integer = lb0 to ub0
			a(idx0).number = counter
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
					CU_ASSERT_EQUAL( c(lb0_c + idx0).number, a(lb0_a + idx0).number )
				next
			end if
		end scope
	#endmacro

	TEST( shift )
		'' expected result array - zero based
		redim as UDT c( 0 to 9 )
		init_array_1d( c(), 0, 9 )

		ctor_count = 0
		dtor_count = 0

		'' array to resize
		dim as UDT a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
		ctor_count = 0
		dtor_count = 0

		'' keep same number of elements but change bounds
		redim preserve a( 1 to 10 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 0 )
		CU_ASSERT_EQUAL( dtor_count, 0 )

		'' keep same number of elements but change bounds
		redim preserve a( -10 to -1 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 0 )
		CU_ASSERT_EQUAL( dtor_count, 0 )

		'' keep same number of elements but change bounds
		redim preserve a( 2 to 11 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 0 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
	END_TEST

	TEST( grow )
		'' expected result array - zero based
		redim as UDT c( 0 to 19 )
		init_array_1d( c(), 0, 9 )

		ctor_count = 0
		dtor_count = 0

		'' array to resize
		dim as UDT a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
		ctor_count = 0
		dtor_count = 0

		'' grow the array
		redim preserve a( 0 to 19 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
	END_TEST

	TEST( shrink )
		'' expected result array - zero based
		redim as UDT c( 0 to 9 )
		init_array_1d( c(), 0, 9 )

		ctor_count = 0
		dtor_count = 0

		'' array to resize
		dim as UDT a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
		ctor_count = 0
		dtor_count = 0

		'' shrink the arrays
		redim preserve a( 0 to 4 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 0 )
		CU_ASSERT_EQUAL( dtor_count, 5 )
	END_TEST

	TEST( shift_and_grow )
		'' expected result array - zero based
		dim as UDT c( 0 to 19 )
		init_array_1d( c(), 0, 9 )

		ctor_count = 0
		dtor_count = 0

		'' array to resize and shift
		dim as UDT a( )
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
		ctor_count = 0
		dtor_count = 0

		'' grow and shift the arrays
		redim preserve a( 5 to 24 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
	END_TEST

	TEST( shift_and_shrink )
		'' expected result array - zero based
		dim as UDT c( 0 to 19 )
		init_array_1d( c(), 0, 19 )

		ctor_count = 0
		dtor_count = 0

		dim as UDT a( ) '' array to resize
		redim a( 0 to 9 )
		init_array_1d( a(), 0, 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 10 )
		CU_ASSERT_EQUAL( dtor_count, 0 )
		ctor_count = 0
		dtor_count = 0

		'' shrink and shift the arrays
		redim preserve a( 5 to 9 )
		check_array( c, a )

		CU_ASSERT_EQUAL( ctor_count, 0 )
		CU_ASSERT_EQUAL( dtor_count, 5 )
	END_TEST

END_SUITE
