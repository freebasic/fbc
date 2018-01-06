/'
	fbcunit example

		- write XML report
'/

#include once "fbcunit.bi"

SUITE( testpass )

	TEST( pass1 )
		CU_ASSERT( true )
	END_TEST

	TEST( pass2 )
		CU_ASSERT( true )
	END_TEST

END_SUITE

SUITE( testfail )

	TEST( pass1 )
		CU_ASSERT( true )
	END_TEST

	TEST( fail2 )
		CU_ASSERT( false )
	END_TEST

END_SUITE

'' no summary
fbcu.run_tests false

fbcu.write_report_xml "results.xml"
