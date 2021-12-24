#include "fbcunit.bi"

SUITE( fbc_tests.string_.asc_ )

	const TEST_A = asc( "abc", 1 )
	const TEST_B = asc( "abc", 2 )
	const TEST_C = asc( "abc", 3 )
	const TEST_D = asc( "abc", 4 )

	TEST( default )

		CU_ASSERT( TEST_A = asc( "a" ) )

		CU_ASSERT( TEST_B = asc( "b" ) )

		CU_ASSERT( TEST_C = asc( "c" ) )

		CU_ASSERT( TEST_D = 0 )

	END_TEST

	TEST( const_ )
		scope
			const S = ""
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 0 )
		end scope

		scope
			const S = "AB"
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 65 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 66 )
			CU_ASSERT_EQUAL( asc(s, 3 ), 0 )
		end scope

		scope
			const S = !"A\000B"
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 65 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 3 ), 66 )
			CU_ASSERT_EQUAL( asc(s, 4 ), 0 )
		end scope

	END_TEST

	TEST( ascii )
		dim s as zstring * 256
		for i as uinteger = 1 to 255
			s[i-1] = i
		next
		dim u as string = s

		CU_ASSERT_EQUAL( asc( s ), asc( u ) )

		for i as integer = -2 to 257
			select case i
			case 1 to 255
				CU_ASSERT_EQUAL( i, asc( u, i ) )
			case else
				CU_ASSERT_EQUAL( 0, asc( u, i ) )
			end select
		next

	END_TEST

	TEST( const_wstr_ )
		scope
			const S = wstr("")
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 0 )
		end scope

		scope
			const S = wstr("AB")
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 65 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 66 )
			CU_ASSERT_EQUAL( asc(s, 3 ), 0 )
		end scope

		scope
			const S = wstr(!"A\000B")
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), 65 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 3 ), 66 )
			CU_ASSERT_EQUAL( asc(s, 4 ), 0 )
		end scope

		'' the following test is invalid for dos
		'' target since sizeof(wstring) = 1
		#if not defined(__FB_DOS__)
		scope
			const S = wstr(!"\u1111\u0000\u2222")
			CU_ASSERT_EQUAL( asc(s, 0 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 1 ), &h1111 )
			CU_ASSERT_EQUAL( asc(s, 2 ), 0 )
			CU_ASSERT_EQUAL( asc(s, 3 ), &h2222 )
			CU_ASSERT_EQUAL( asc(s, 4 ), 0 )
		end scope
		#endif

	END_TEST

END_SUITE
