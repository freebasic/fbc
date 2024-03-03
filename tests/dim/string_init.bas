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

		dim s3 as string * 5 = ""
		dim as string * 5 s4 = ""

		dim s5 as string * 5
		dim as string * 5 s6

		CU_ASSERT( s1 = "test " )
		CU_ASSERT( s2 = "test " )
		CU_ASSERT( s3 = space( 5 ) )
		CU_ASSERT( s4 = space( 5 ) )
		CU_ASSERT( s5 = space( 5 ) )
		CU_ASSERT( s6 = space( 5 ) )
	END_TEST

END_SUITE
