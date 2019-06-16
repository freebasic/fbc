#include "fbcunit.bi"
#include once "chk-wstring.bi"

SUITE( fbc_tests.wstring_.strptr_ )

	TEST( deref )
		dim s1 as wstring * 50 = "1234"
		dim s2 as wstring * 50 = s1

		dim as wstring ptr p1 = @s1
		CU_ASSERT( p1 <> strptr( s2 ) )

		CU_ASSERT_WSTRING_EQUAL( s1, s2 )
		CU_ASSERT_WSTRING_EQUAL( (*p1), s2 )

	END_TEST

	TEST( ptr_size )

		dim s1 as wstring * 50 = "1234"

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
