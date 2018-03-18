#include "fbcunit.bi"

SUITE( fbc_tests.quirk.casting )

	sub do_negate( byref v as integer )
		v = -v
	end sub

	TEST( byref_ )
		dim i as integer
		
		'' this type-casting shouldn't matter
		i = 1234
		do_negate cint( i )
		CU_ASSERT_EQUAL( i, -1234 )

		'' ditto
		i = 1234
		do_negate cuint( i )
		CU_ASSERT_EQUAL( i, -1234 )

		'' this should
		i = 1234
		do_negate cshort( i )
		CU_ASSERT_EQUAL( i, 1234 )
		
	END_TEST

	function fun( a as integer, b as integer, c as integer ) as integer
		function = 5678
	end function

	TEST( call_ )

		'' calling a function as a sub + casting
		cuint( fun( 1, 2, 3 ) )

	END_TEST

	TEST( selfbop )

		dim as integer i

		'' no carry
		i = &b10000000000000000000000000000000
		CU_ASSERT( i = &h80000000 )
		cuint( i ) shr= 1
		CU_ASSERT( i = &b01000000000000000000000000000000 )

		#ifdef __FB_64BIT__
			'' no carry
			i = &b10000000000000000000000000000000
			CU_ASSERT( i = &h80000000 )
			cint( i ) shr= 1
			CU_ASSERT( i = &b01000000000000000000000000000000 )

			'' carry
			i = &b1000000000000000000000000000000000000000000000000000000000000000
			CU_ASSERT( i = &h8000000000000000 )
			cint( i ) shr= 1
			CU_ASSERT( i = &b1100000000000000000000000000000000000000000000000000000000000000 )
		#else
			'' carry
			i = &b10000000000000000000000000000000
			CU_ASSERT( i = &h80000000 )
			cint( i ) shr= 1
			CU_ASSERT( i = &b11000000000000000000000000000000 )
		#endif

		dim as longint ll

		'' no carry
		ll = &b1000000000000000000000000000000000000000000000000000000000000000
		CU_ASSERT( ll = &h8000000000000000 )
		culngint( ll ) shr= 1
		CU_ASSERT( ll = &b0100000000000000000000000000000000000000000000000000000000000000 )

		'' carry
		ll = &b1000000000000000000000000000000000000000000000000000000000000000
		CU_ASSERT( ll = &h8000000000000000 )
		clngint( ll ) shr= 1
		CU_ASSERT( ll = &b1100000000000000000000000000000000000000000000000000000000000000 )

	END_TEST

	TEST( data_ )

		restore mydata

		dim as zstring ptr ps
		read ps
		CU_ASSERT_EQUAL( *ps, "fOObAR" )

		dim as double ptr pd
		read pd
		CU_ASSERT_EQUAL( *pd, 1234.5 )

		dim as integer ptr pi
		read pi
		CU_ASSERT_EQUAL( *pi, -5678 )

	END_TEST

END_SUITE

	static shared as double mydbl = 1234.5
	static shared as integer myint = -5678

mydata:
	data @"fOObAR", @mydbl, @myint
