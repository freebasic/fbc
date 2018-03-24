# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.idiv_by_float )

	TEST( testproc )

		CU_ASSERT_EQUAL( 4.5 \ 1.5, 2 ) '' = 4 \ 2 = 2, not int(4.5 / 1.5) = 3
		CU_ASSERT_EQUAL( 4 \ 1.5, 2 )
		CU_ASSERT_EQUAL( 4u \ 1.5, 2 )
		CU_ASSERT_EQUAL( 4ll \ 1.5, 2 )
		CU_ASSERT_EQUAL( 4ull \ 1.5, 2 )

		dim sb as byte = 4, ub as ubyte = 4, ss as short = 4, us as ushort = 4
		dim sl as long = 4, ul as ulong = 4, si as integer = 4, ui as uinteger = 4
		dim sll as longint = 4, ull as ulongint = 4
		dim s as single = 4.5, d as double = 4.5

		CU_ASSERT_EQUAL( sb \ 1.5, 2 )
		CU_ASSERT_EQUAL( ub \ 1.5, 2 )
		CU_ASSERT_EQUAL( ss \ 1.5, 2 )
		CU_ASSERT_EQUAL( us \ 1.5, 2 )
		CU_ASSERT_EQUAL( sl \ 1.5, 2 )
		CU_ASSERT_EQUAL( ul \ 1.5, 2 )
		CU_ASSERT_EQUAL( si \ 1.5, 2 )
		CU_ASSERT_EQUAL( ui \ 1.5, 2 )
		CU_ASSERT_EQUAL( sll \ 1.5, 2 )
		CU_ASSERT_EQUAL( ull \ 1.5, 2 )
		CU_ASSERT_EQUAL( s \ 1.5, 2 )
		CU_ASSERT_EQUAL( d \ 1.5, 2 )

		s = 1.5

		CU_ASSERT_EQUAL( 4.5 \ s, 2 )
		CU_ASSERT_EQUAL( 4 \ s, 2 )
		CU_ASSERT_EQUAL( 4u \ s, 2 )
		CU_ASSERT_EQUAL( 4ll \ s, 2 )
		CU_ASSERT_EQUAL( 4ull \ s, 2 )

		CU_ASSERT_EQUAL( d \ s, 2 )

	END_TEST

END_SUITE
