#include once "fbcunit.bi"

'' tests added to global suite
'' - when TEST() appears outside of a SUITE() block
''   it is automatically added to the default global
''   test suite

TEST( default1 )
	CU_ASSERT( *fbcu.get_suite_name() = "fbcu_global" )
	CU_ASSERT( true )
END_TEST

TEST( default2 )
	CU_ASSERT( true )
END_TEST

TEST( default3 )
	CU_ASSERT( true )
END_TEST

'' tests added to a named suite

SUITE( named_suite )

	TEST( first )
		CU_ASSERT( *fbcu.get_suite_name() = "named_suite" )
		CU_ASSERT( true )
	END_TEST

	TEST( second )
		CU_ASSERT( *fbcu.get_suite_name() = "named_suite" )
		CU_ASSERT( true )
	END_TEST

END_SUITE

'' tests added to global suite

TEST( default4 )
	CU_ASSERT( true )
END_TEST

TEST( default5 )
	CU_ASSERT( true )
END_TEST
