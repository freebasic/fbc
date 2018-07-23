#include "fbcunit.bi"

'' option escape

SUITE( fbc_tests.wstring_.unc )

	TEST( escape )

		#define hello !"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 "
		#define world !"\u03ba\u03cc\u03c3\u03bc\u03b5!"
		#define helloworld hello + world

		dim as wstring * 128 hw1 = !"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 \u03ba\u03cc\u03c3\u03bc\u03b5!"
		dim as wstring * 128 hw2 = helloworld

		CU_ASSERT( hw1 = hw2 )

		CU_ASSERT( hw1 = helloworld )

		CU_ASSERT( helloworld = hw2 )

	END_TEST

	TEST( noescape )

		#define hello $"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 "
		#define world $"\u03ba\u03cc\u03c3\u03bc\u03b5!"
		#define helloworld hello + world

		dim as wstring * 128 hw1 = $"\u039a\u03b1\u03bb\u03b7\u03bc\u03ad\u03c1\u03b1 \u03ba\u03cc\u03c3\u03bc\u03b5!"
		dim as wstring * 128 hw2 = helloworld

		CU_ASSERT( hw1 = hw2 )

		CU_ASSERT( hw1 = helloworld )

		CU_ASSERT( helloworld = hw2 )

	END_TEST

END_SUITE
