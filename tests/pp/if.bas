#include "fbcunit.bi"

SUITE( fbc_tests.pp.if_ )

	TEST( all )
		dim as integer i = 0
		dim as string s

		#if 1
			CU_PASS( )
			i = 1
		#endif
		CU_ASSERT( i = 1 )
		i = 0

		#if 0
			CU_FAIL( )
			i = 1
		#endif
		CU_ASSERT( i = 0 )

		#if 1
			CU_PASS( )
			i = 1
		#else
			CU_FAIL( )
			i = 2
		#endif
		CU_ASSERT( i = 1 )
		i = 0

		#if 0
			CU_FAIL( )
			i = 1
		#else
			CU_PASS( )
			i = 2
		#endif
		CU_ASSERT( i = 2 )
		i = 0

		#if "test"
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		#if 1 = 2
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		#if 1 = 5 - (((4 * 2) + 8) / 4)
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if (1 + 2 + 3) <> 6
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		#if (1 + (2 * 3)) <> 7
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		#if (1 + 2 + 3 - 4) <> 2
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		CU_ASSERT( (1/2) > .49 )
		#if (1/2) > .49
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if (10\5) <> 2
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		CU_ASSERT( &hFFFFFFFFu > 0 )
		#if &hFFFFFFFFu > 0
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		CU_ASSERT( &hFFFFFFFFu > 0u )
		#if &hFFFFFFFFu > 0u
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0 )
		#if &hFFFFFFFFFFFFFFFFull > 0
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0u )
		#if &hFFFFFFFFFFFFFFFFull > 0u
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0ull )
		#if &hFFFFFFFFFFFFFFFFull > 0ull
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if "a" + "b" = "ab"
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		const N1 = 123
		#if N1 = 123
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		const S1 = "abc"
		#if "abc" = S1
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if undeclaredid
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		#if undeclaredid = undeclaredid
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if undeclaredid = UNDECLAREDID
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if UNDECLAREDID = undeclaredid
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if undeclaredid1 = undeclaredid2
			CU_FAIL( )
		#else
			CU_PASS( )
		#endif

		'' Besides undeclared identifiers, quirk function names should also be
		'' accepted as literals, for better backwards compatibility
		#if typeof( s ) = string
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if typeof( s ) <> string
			CU_FAIL( )
		#endif

		#if typeof( s ) <> STRING
			CU_FAIL( )
		#endif

		#if string <> typeof( s )
			CU_FAIL( )
		#endif

		#if STRING <> typeof( s )
			CU_FAIL( )
		#endif

		#if name <> name
			CU_FAIL( )
		#endif

		#if name <> NAME
			CU_FAIL( )
		#endif

		#if undeclaredid = name
			CU_FAIL( )
		#endif

		#if name = undeclaredid
			CU_FAIL( )
		#endif

		'' constant
		#if defined( N1 )
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if defined( N1 ) = -1
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		#if -1 = defined( N1 )
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		'' variable
		#if defined( i )
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif

		'' procedure
		#if defined( test )
			CU_PASS( )
		#else
			CU_FAIL( )
		#endif
	END_TEST

END_SUITE
