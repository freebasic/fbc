#include "fbcunit.bi"

SUITE( fbc_tests.overload_.bop_coercion2 )

	enum TEST_RES
		TEST_RES_byte
		TEST_RES_short
		TEST_RES_integer
		TEST_RES_longint
		TEST_RES_single
		TEST_RES_double
	end enum

	const TEST_L_VAL = 1.2345
	const TEST_R_VAL = 1234.5

	type foo
		bar as double
		declare operator cast ( ) as byte
		declare operator cast ( ) as short
		declare operator cast ( ) as integer
		declare operator cast ( ) as longint
		declare operator cast ( ) as single
		declare operator cast ( ) as double
	end type

	#macro hGenCast( tp )
		operator foo.cast ( ) as tp
			operator = bar
		end operator
	#endmacro

	hGenCast( byte )
	hGenCast( short )
	hGenCast( integer )
	hGenCast( longint )
	hGenCast( single )
	hGenCast( double )

	#macro hGenTest( tp )
		function func overload ( byval v as tp ) as TEST_RES
			CU_ASSERT_EQUAL( v, TEST_L_VAL + TEST_R_VAL )
			function = TEST_RES_##tp
		end function
	#endmacro

	hGenTest( byte )
	hGenTest( short )
	hGenTest( integer )
	hGenTest( longint )
	hGenTest( single )
	hGenTest( double )
  
	TEST( all )
		dim as foo l = ( TEST_L_VAL ), r = ( TEST_R_VAL )
		CU_ASSERT_EQUAL( func( l + r ), TEST_RES_DOUBLE )
	END_TEST

END_SUITE
