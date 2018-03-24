#include once "fbcunit.bi"
#include once "crt/long.bi"

SUITE( fbc_tests.crt.clong_ )

	TEST( clong_size )
		CU_ASSERT( sizeof( clong ) = sizeof( culong ) )

		#ifdef __FB_64BIT__
			#ifdef __FB_WIN32__
				CU_ASSERT( sizeof( clong ) = 4 )
			#else
				CU_ASSERT( sizeof( clong ) = 8 )
			#endif
		#else
			CU_ASSERT( sizeof( clong ) = 4 )
		#endif
	END_TEST

END_SUITE
