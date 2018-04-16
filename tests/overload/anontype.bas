#include "fbcunit.bi"

SUITE( fbc_tests.overload_.anontype )

	type udt1
		a as integer
		b as integer
	end type

	type udt2
		a as integer
		b as integer
		c as integer
	end type

	const TEST1_A = 1, TEST1_B = 2
	const TEST2_A = 3, TEST2_B = 4, TEST2_C = 3

	function proc overload (byref x as udt1) as udt1
		
		CU_ASSERT_EQUAL( x.a, TEST1_A )
		CU_ASSERT_EQUAL( x.b, TEST1_B )

		function = type<udt1>( x.a, x.b )
		
	end function

	function proc (byref x as udt2) as udt1
		
		CU_ASSERT_EQUAL( x.a, TEST2_A )
		CU_ASSERT_EQUAL( x.b, TEST2_B )
		CU_ASSERT_EQUAL( x.c, TEST2_C )

		function = type<udt1>( x.a, x.b )
		
	end function

	TEST( arguments_and_returns )
		
		dim as udt1 res
		
		res = proc( type<udt1>( TEST1_A, TEST1_B ) )
		CU_ASSERT( res.a = TEST1_A and res.b = TEST1_B )
		
		res = proc( type<udt2>( TEST2_A, TEST2_B, TEST2_C ) )
		CU_ASSERT( res.a = TEST2_A and res.b = TEST2_B )
		
	END_TEST

END_SUITE
