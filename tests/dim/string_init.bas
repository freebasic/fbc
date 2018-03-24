# include "fbcunit.bi"

SUITE( fbc_tests.dim_.string_init )

	TEST( variableLength )
		dim as string s1 = "test"
		dim s2 as string = "test"
		CU_ASSERT( s1 = "test" )
		CU_ASSERT( s2 = "test" )
	END_TEST

	TEST( fixedLength )
		dim as string * 5 s1 = "test"
		dim s2 as string * 5 = "test"
		CU_ASSERT( s1 = "test" )
		CU_ASSERT( s2 = "test" )
	END_TEST

END_SUITE
