#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_uniqueid )


	TEST( unused )

		'' before __FB_UNIQUEID_PUSH__() creates a stack
		'' __FB_UNIQUEID__() should return an empty string

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __unused__ ) ), "" )

	END_TEST

	TEST( empty )

		'' __FB_UNIQUEID__() should return an empty string if stack is empty

		__FB_UNIQUEID_PUSH__( __empty__ )
		__FB_UNIQUEID_POP__( __empty__ )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __empty__ ) ), "" )

	END_TEST

	TEST( not_global )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __ns__ ) ), "" )

		__FB_UNIQUEID_PUSH__( __ns__ )

		#if defined( __ns__ )
			CU_FAIL()
		#endif

		__FB_UNIQUEID_POP__( __ns__ )

	END_TEST

	TEST( direct )

		__FB_UNIQUEID_PUSH__( __direct__ )
		#define L1 __FB_UNIQUEID__( __direct__ )

		__FB_UNIQUEID_PUSH__( __direct__ )
		#define L2 __FB_UNIQUEID__( __direct__ )

		__FB_UNIQUEID_PUSH__( __direct__ )
		#define L3 __FB_UNIQUEID__( __direct__ )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __direct__ ) ), __FB_QUOTE__( L3 ) )
		__FB_UNIQUEID_POP__( __direct__ )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __direct__ ) ), __FB_QUOTE__( L2 ) )
		__FB_UNIQUEID_POP__( __direct__ )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __direct__ ) ), __FB_QUOTE__( L1 ) )
		__FB_UNIQUEID_POP__( __direct__ )

	END_TEST

	TEST( skipping )

		__FB_UNIQUEID_PUSH__( __skip__ )
		#define L1 __FB_UNIQUEID__( __skip__ )

		#if 0
			__FB_UNIQUEID__( __skip__ )
		#endif	

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_UNIQUEID__( __skip__ ) ), __FB_QUOTE__( L1 ) )
		__FB_UNIQUEID_POP__( __skip__ )

	END_TEST

END_SUITE

 
