#include "fbcunit.bi"
	
SUITE( fbc_tests.optimizations.mul_assoc )

	const TEST_VAL0 as integer = 10
	const TEST_VAL1 as integer = 1
	const TEST_VAL2 as double = 2.0
	const TEST_VAL3 as integer = 3
	const TEST_VAL4 as integer = 4
	const TEST_VAL5 as double = 5.0

	function foo( byval value as double ) as double
		function = value
	end function

	function bar( ) as double
		function = TEST_VAL5
	end function

	# macro D_TEST_PROC(T_)
	TEST( test##T_ )
		dim as T_ v = TEST_VAL0
		dim as double res1, res2
		dim as double tmp1, tmp2, tmp3

		res1 = TEST_VAL1 + foo( TEST_VAL2 * v * (bar() * TEST_VAL3) ) * TEST_VAL4

		res2 = TEST_VAL1
		tmp1 = TEST_VAL2 * v
		tmp2 = bar() * TEST_VAL3
		tmp3 = foo( tmp1 * tmp2 ) * TEST_VAL4
 		res2 += tmp3

		CU_ASSERT_EQUAL( res1, res2 )
	END_TEST
	# endmacro

	D_TEST_PROC(byte)
	D_TEST_PROC(ubyte)
	D_TEST_PROC(short)
	D_TEST_PROC(ushort)
	D_TEST_PROC(integer)
	D_TEST_PROC(uinteger)
	D_TEST_PROC(longint)
	D_TEST_PROC(ulongint)
	D_TEST_PROC(single)
	D_TEST_PROC(double)

	# undef D_TEST_PROC
		
END_SUITE
