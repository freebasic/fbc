#include "fbcunit.bi"

SUITE( fbc_tests.numbers.cast_unsigned )

	TEST( ubyte_ )
		dim as integer dst, src
		
		src = &hFFFFFFFF
		dst = cubyte( src )
		
		CU_ASSERT_EQUAL( dst, &hFF )
	END_TEST

	TEST( ushort_ )
		dim as integer dst, src
		
		src = &hFFFFFFFF
		dst = cushort( src )
		
		CU_ASSERT_EQUAL( dst, &hFFFF )
	END_TEST

	TEST( uinteger_ )
		dim as integer dst, src
		
		src = &hFFFFFFFF
		dst = cuint( src )
		
		CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
	END_TEST

END_SUITE
