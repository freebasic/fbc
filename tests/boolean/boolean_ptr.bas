# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

SUITE( fbc_tests.boolean_.boolean_ptr )

	''
	TEST( compare )

		dim as boolean i
		dim as boolean ptr b = @i

		i =  0: CU_ASSERT_EQUAL( *b, cbool(i) )
		i =  1: CU_ASSERT_EQUAL( *b, cbool(i) )
		i =  2: CU_ASSERT_EQUAL( *b, cbool(i) )
		i = -1: CU_ASSERT_EQUAL( *b, cbool(i) )

	END_TEST

	
END_SUITE
