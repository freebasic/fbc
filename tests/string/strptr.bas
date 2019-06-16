#include "fbcunit.bi"

SUITE( fbc_tests.string_.strptr_ )

	TEST( deref )
		dim as string ptr foo
		dim as string bar = "1234"
		dim as zstring ptr p

		foo = @bar
		p = strptr( *foo )
		CU_ASSERT_EQUAL( *p, "1234" )
	END_TEST

	TEST( ptr_size )

		dim s1 as zstring * 50 = "1234"
		dim as zstring ptr p0 = @s1

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
