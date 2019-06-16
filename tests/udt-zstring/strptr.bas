#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.strptr_ )

	TEST( deref )
		dim s1 as zstring * 50 = "1234"
		dim u1 as ustring = s1

		dim as zstring ptr p1 = strptr( u1 )

		CU_ASSERT_zstring_EQUAL( (*p1), s1 )
	END_TEST

	TEST( ptr_size )

		dim s as zstring * 50 = "1234"
		dim s1 as ustring = s

		scope
			dim as zstring ptr p1 = strptr(s1)
			dim as zstring ptr p2 = (strptr(s1) + 1)
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( zstring ) )
		end scope

		scope
			dim as zstring ptr p1 = strptr(s1)
			dim as zstring ptr p2 = @(strptr(s1)[1])
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( zstring ) )
		end scope

		scope
			dim as zstring ptr p1 = sadd(s1)
			dim as zstring ptr p2 = (sadd(s1) + 1)
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( zstring ) )
		end scope

		scope
			dim as zstring ptr p1 = sadd(s1)
			dim as zstring ptr p2 = @(sadd(s1)[1])
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( zstring ) )
		end scope

	END_TEST
		
END_SUITE
