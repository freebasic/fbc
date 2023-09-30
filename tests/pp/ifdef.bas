#include "fbcunit.bi"

'' - don't mix false/true intrinsic constants
''   of the compiler in with these tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE NOT FALSE

#define A_DEFINED

SUITE( fbc_tests.pp.ifdef )

	TEST( ifdefTestDefined )
		#ifdef A_DEFINED
			CU_PASS("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

	TEST( ifdefTestNotDefined )
		#ifdef B_NOT_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_PASS("")
		#endif
	END_TEST

	TEST( ifndefTestDefined )
		#ifndef A_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_PASS("")
		#endif
	END_TEST

	TEST( ifndefTestNotDefined )
		#ifndef B_NOT_DEFINED
			CU_PASS("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

	TEST( elseifdefTestDefined )
		#if 0
			CU_FAIL_FATAL("")
		#elseifdef A_DEFINED
			CU_PASS("")
		#else
			CU_FAIL_FATAL("")
		#endif

		#if 1
			CU_PASS("")
		#elseifdef A_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

	TEST( elseifdefTestNotDefined )
		#if 0
			CU_FAIL_FATAL("")
		#elseifdef B_NOT_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_PASS("")
		#endif

		#if 1
			CU_PASS("")
		#elseifdef B_NOT_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

	TEST( elseifndefTestDefined )
		#if 0
			CU_FAIL_FATAL("")
		#elseifndef A_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_PASS("")
		#endif

		#if 1
			CU_PASS("")
		#elseifndef A_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

	TEST( elseifndefTestNotDefined )
		#if 0
			CU_FAIL_FATAL("")
		#elseifndef B_NOT_DEFINED
			CU_PASS("")
		#else
			CU_FAIL_FATAL("")
		#endif

		#if 1
			CU_PASS("")
		#elseifndef B_NOT_DEFINED
			CU_FAIL_FATAL("")
		#else
			CU_FAIL_FATAL("")
		#endif
	END_TEST

END_SUITE
