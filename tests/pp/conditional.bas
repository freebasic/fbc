#include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with these tests
#undef FALSE
#undef TRUE

# define FALSE 0
# define TRUE NOT FALSE

# define FOO TRUE

SUITE( fbc_tests.pp.conditional )

	TEST( ifEqualityTest )

		# if FOO = TRUE
		CU_PASS("")
		# else
		CU_FAIL_FATAL("")
		# endif

	END_TEST

	TEST( ifInequalityTest )

		# if FOO <> FALSE and not defined(BAR)
		CU_PASS("")
		# else
		CU_FAIL_FATAL("")
		# endif

	END_TEST

	TEST( elseifDefinedTest )

		# if defined(FOO) and defined(BAR)
		CU_FAIL_FATAL("")
		# elseif not defined(FOO) and defined(BAR)
		CU_FAIL_FATAL("")
		# elseif defined(FOO) and not defined(BAR)
		CU_PASS("")
		# elseif not defined(FOO) or not defined(BAR)
		CU_FAIL_FATAL("")
		# endif

	END_TEST

END_SUITE
