#include "fbcunit.bi"

SUITE( fbc_tests.numbers.casting )

	TEST( byte_ )
		dim as integer dst, src
		
		src = &hFF
		dst = cubyte( cuint( src ) )
		
		CU_ASSERT_EQUAL( dst, &hFF )
	END_TEST

	TEST( short_ )
		dim as integer dst, src
		
		src = &hFFFF
		dst = cushort( cuint( src ) )
		
		CU_ASSERT_EQUAL( dst, &hFFFF )
	END_TEST

	TEST( integer_ )
		dim as integer dst, src
		
		src = &hFFFFFFFF
		dst = cuint( src )
		
		CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
	END_TEST

	TEST( float_to_int )
		'' Some float-to-int casting to ensure it compiles fine, including the
		'' regression test for bug #3310595.
		dim as single f = 123
		CU_ASSERT( cbyte( f ) = 123 )
		CU_ASSERT( cubyte( f ) = 123 )
		CU_ASSERT( cshort( f ) = 123 )
		CU_ASSERT( cushort( f ) = 123 )
		CU_ASSERT( cint( f ) = 123 )
		CU_ASSERT( cuint( f ) = 123 )
		CU_ASSERT( clng( f ) = 123 )
		CU_ASSERT( culng( f ) = 123 )
		CU_ASSERT( clngint( f ) = 123 )
		CU_ASSERT( culngint( f ) = 123 )

		dim as double d = 123
		CU_ASSERT( cbyte( d ) = 123 )
		CU_ASSERT( cubyte( d ) = 123 )
		CU_ASSERT( cshort( d ) = 123 )
		CU_ASSERT( cushort( d ) = 123 )
		CU_ASSERT( cint( d ) = 123 )
		CU_ASSERT( cuint( d ) = 123 )
		CU_ASSERT( clng( d ) = 123 )
		CU_ASSERT( culng( d ) = 123 )
		CU_ASSERT( clngint( d ) = 123 )
		CU_ASSERT( culngint( d ) = 123 )
	END_TEST

END_SUITE
