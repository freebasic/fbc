# include "fbcu.bi"

namespace fbc_tests.numbers.longints

#define TEST_SL1 &h7FFFFFFFFFFFFFLL
#define TEST_SL2 &hFFFFLL
#define TEST_UL1 &hFFFFFFFFFFFFFFULL
#define TEST_UL2 &hFFFFFULL

#define TEST_D cdbl(65536.0)

sub test_div cdecl ()
	dim as longint v1
	v1 = TEST_SL1
	v1 /= TEST_D
	CU_ASSERT( v1 = cast( longint, TEST_SL1 / TEST_D ) )

	dim as ulongint v2
	v2 = TEST_UL1
	v2 /= TEST_D
	CU_ASSERT( v2 = cast( ulongint, TEST_UL1 / TEST_D ) )
	
end sub

sub test_intdiv cdecl ()
	dim as longint v1
	v1 = TEST_SL1
	v1 \= TEST_SL2
	CU_ASSERT( v1 = TEST_SL1 \ TEST_SL2 )

	dim as ulongint v2
	v2 = TEST_UL1
	v2 \= TEST_UL2
	CU_ASSERT( v2 = TEST_UL1 \ TEST_UL2 )
	
end sub

sub test_shift cdecl ()
	dim as longint v1
	v1 = 2 ^ 34
	v1 shr= 34
	CU_ASSERT( v1 = 1 )

	dim as ulongint v2
# print one warning to follow
	v2 = 2 ^ 34
	v2 shr= 34
	CU_ASSERT( v2 = 1 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.longints")
	fbcu.add_test("test_div", @test_div)
	fbcu.add_test("test_intdiv", @test_intdiv)
	fbcu.add_test("test_shift", @test_shift)

end sub

end namespace
