#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.asc_ )

	TEST( ascii )
		dim s as zstring * 256
		for i as uinteger = 1 to 255
			s[i-1] = i
		next
		dim u as ustring = s

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

'' only test where sizeof(wstring) >= 2, because
'' it won't be on DOS where sizeof(wstring) = 1.
#if sizeof(WSTRING) >= 2
	TEST( ucs2 )
		dim s as zstring * 256
		for i as uinteger = 1 to 255
			s[i-1] = i shl 8
		next
		dim u as ustring = s

		CU_ASSERT_EQUAL( asc( s ), asc( u ) )

		for i as integer = -2 to 257
			select case i
			case 1 to 255
				CU_ASSERT_EQUAL( asc( s, i ), asc( u, i ) )
			case else
				CU_ASSERT_EQUAL( 0, asc( u, i ) )
			end select
		next

	END_TEST
#endif

END_SUITE
