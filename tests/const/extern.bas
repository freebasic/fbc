# include "fbcunit.bi"

extern const_extern_integer as const integer

dim shared const_extern_integer as const integer = 1234

SUITE( fbc_tests.const_.extern_ )

	TEST( test_extern )
		
		CU_ASSERT_EQUAL( const_extern_integer, 1234 )
		
	END_TEST

END_SUITE
