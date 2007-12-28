# include "fbcu.bi"
	
namespace fbc_tests.optimizations.mul_assoc

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
sub test_##T_ cdecl ()
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
end sub
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
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:multiplication association")
	fbcu.add_test("test_byte", @test_byte)
	fbcu.add_test("test_ubyte", @test_ubyte)
	fbcu.add_test("test_short", @test_short)
	fbcu.add_test("test_ushort", @test_ushort)
	fbcu.add_test("test_integer", @test_integer)
	fbcu.add_test("test_uinteger", @test_uinteger)
	fbcu.add_test("test_longint", @test_longint)
	fbcu.add_test("test_ulongint", @test_ulongint)
	fbcu.add_test("test_single", @test_single)
	fbcu.add_test("test_double", @test_double)

end sub

end namespace
