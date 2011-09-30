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

	dim as integer i

	v2 = &h1234567ABCDEFABCull
	v2 shr= 36
	CU_ASSERT( v2 = &h0000000001234567ull )

	v2 = &h1234567ABCDEFABCull
	i = 36
	v2 shr= i
	CU_ASSERT( v2 = &h0000000001234567ull )

	

	v2 = &hABCDEFABC1234567ull
	v2 shl= 36
	CU_ASSERT( v2 = &h1234567000000000ull )

	v2 = &hABCDEFABC1234567ull
	i = 36
	v2 shl= i
	CU_ASSERT( v2 = &h1234567000000000ull )



	v2 = &h12345678ABCDEFABull
	v2 shr= 32
	CU_ASSERT( v2 = &h0000000012345678ull )

	v2 = &h12345678ABCDEFABull
	i = 32
	v2 shr= i
	CU_ASSERT( v2 = &h0000000012345678ull )



	v2 = &hABCDEFAB12345678ull
	v2 shl= 32
	CU_ASSERT( v2 = &h1234567800000000ull )

	v2 = &hABCDEFAB12345678ull
	i = 32
	v2 shl= i
	CU_ASSERT( v2 = &h1234567800000000ull )



	v2 = &h123456789ABCDEFAull
	v2 shr= 28
	CU_ASSERT( v2 = &h0000000123456789ull )

	v2 = &h123456789ABCDEFAull
	i = 28
	v2 shr= i
	CU_ASSERT( v2 = &h0000000123456789ull )



	v2 = &hABCDEFA123456789ull
	v2 shl= 28
	CU_ASSERT( v2 = &h1234567890000000ull )

	v2 = &hABCDEFA123456789ull
	i = 28
	v2 shl= i
	CU_ASSERT( v2 = &h1234567890000000ull )


end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.longints")
	fbcu.add_test("test_div", @test_div)
	fbcu.add_test("test_intdiv", @test_intdiv)
	fbcu.add_test("test_shift", @test_shift)

end sub

end namespace
