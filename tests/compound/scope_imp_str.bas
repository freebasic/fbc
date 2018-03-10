# include "fbcunit.bi"

SUITE( fbc_tests.compound.scope_imp_str )

	const TEST_STR1 = "foobar"
	const TEST_STR2 = "1234"

	TEST( test_zstring )

		dim zs1 as zstring ptr = @TEST_STR1
		dim zs2 as zstring ptr = @TEST_STR2
		dim as string res
		
		'' implicit scope with a hidden var allocated
		if( 1 ) then
			res = *zs1 + *zs2
		end if
		
		CU_ASSERT( res = TEST_STR1 + TEST_STR2 )
		
	END_TEST

	TEST( test_string )

		dim s1 as string = TEST_STR1
		dim s2 as string = TEST_STR2
		dim as string res
		
		'' implicit scope with no hidden var allocated
		if( 1 ) then
			res = s1 + s2
		end if
		
		CU_ASSERT( res = TEST_STR1 + TEST_STR2 )
		
	END_TEST

END_SUITE
