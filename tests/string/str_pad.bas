#include "fbcunit.bi"

SUITE( fbc_tests.string_.str_pad )

	TEST( integerToStr )
		dim as integer i = 1
		cu_assert( str(i) = "1" )
		i = -1
		cu_assert( str(i) = "-1" )
		cu_assert( str(1) = "1" )
		cu_assert( str(-1) = "-1" )
	END_TEST

	TEST( uintegerToStr )
		dim as uinteger ui = 1
		cu_assert( str(ui) = "1" )
		cu_assert( str(1ul) = "1" )
	END_TEST
	
	TEST( singleToStr )
		dim as single s = 1
		cu_assert( str(s) = "1" )
		s = -1
		cu_assert( str(s) = "-1" )
		cu_assert( str(1!) = "1" )
		cu_assert( str(-1!) = "-1" )
	END_TEST

	TEST( doubleToStr )
		dim as double d = 1
		cu_assert( str(d) = "1" )
		d = -1
		cu_assert( str(d) = "-1" )
		cu_assert( str(1#) = "1" )
		cu_assert( str(-1#) = "-1" )
	END_TEST
	
	TEST( longintToStr )
		dim as longint l = 1
		cu_assert( str(l) = "1" )
		l = -1
		cu_assert( str(l) = "-1" )
		cu_assert( str(1ll) = "1" )
		cu_assert( str(-1ll) = "-1" )
	END_TEST

	TEST( ulongintToStr )
		dim as ulongint ul = 1
		cu_assert( str(ul) = "1" )
		cu_assert( str(1ull) = "1" )
	END_TEST

END_SUITE
