#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.asc_ )

	const TEST_A = asc( wstr( "abc" ), 1 )
	const TEST_B = asc( wstr( "abc" ), 2 )
	const TEST_C = asc( wstr( "abc" ), 3 )
	const TEST_D = asc( wstr( "abc" ), 4 )

	TEST( default )

		CU_ASSERT( TEST_A = asc( wstr( "a" ) ) )
		
		CU_ASSERT( TEST_B = asc( wstr( "b" ) ) )
		
		CU_ASSERT( TEST_C = asc( wstr( "c" ) ) )
		
		CU_ASSERT( TEST_D = 0 )
		
	END_TEST

	TEST( ascii )
		dim w as wstring * 256
		for i as integer = 1 to 255
			w[i-1] = i
		next
		
		CU_ASSERT_EQUAL( 1, asc( w ) )

		for i as integer = -2 to 257
			select case i
			case 1 to 255
				CU_ASSERT_EQUAL( i, asc( w, i ) )
			case else
				CU_ASSERT_EQUAL( 0, asc( w, i ) )
			end select
		next
	END_TEST

'' only test where sizeof(wstring) >= 2, because
'' it won't be on DOS where sizeof(wstring) = 1.
#if sizeof(WSTRING) >= 2
	TEST( ucs2 )
		dim w as wstring * 256
		for i as integer = 1 to 255
			w[i-1] = i shl 8
		next

		CU_ASSERT_EQUAL( 256, asc( w ) )

		for i as integer = -2 to 257
			select case i
			case 1 to 255
				CU_ASSERT_EQUAL( w[i-1], asc( w, i ) )
			case else
				CU_ASSERT_EQUAL( 0, asc( w, i ) )
			end select
		next
	END_TEST
#endif

END_SUITE
