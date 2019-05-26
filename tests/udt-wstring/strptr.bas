#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.strptr_ )

	TEST( deref )
		dim s1 as wstring * 50 = "1234"
		dim u1 as ustring = s1

		dim as wstring ptr p1 = strptr( u1 )

		CU_ASSERT_WSTRING_EQUAL( (*p1), s1 )
	END_TEST

	TEST( ptr_size )

		dim s as wstring * 50 = "1234"
		dim s1 as ustring = s

		scope
			dim as wstring ptr p1 = strptr(s1)
			dim as wstring ptr p2 = (strptr(s1) + 1)
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( wstring ) )
		end scope

		scope
			dim as wstring ptr p1 = strptr(s1)
			dim as wstring ptr p2 = @(strptr(s1)[1])
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( wstring ) )
		end scope

		scope
			dim as wstring ptr p1 = sadd(s1)
			dim as wstring ptr p2 = (sadd(s1) + 1)
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( wstring ) )
		end scope

		scope
			dim as wstring ptr p1 = sadd(s1)
			dim as wstring ptr p2 = @(sadd(s1)[1])
			CU_ASSERT_EQUAL( cint(p2) - cint(p1), sizeof( wstring ) )
		end scope

	END_TEST
		
END_SUITE
