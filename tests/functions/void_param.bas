# include "fbcunit.bi"

SUITE( fbc_tests.functions.void_param )

	declare  sub test_const( byref p as any )
	declare  sub test_byval( byref p as any )
	declare  sub test_str( byref p as any )
		
	TEST( default )

		test_const 1234
		test_const byval 1234
		
		dim i as integer = 5678
		test_byval byval i
		
		test_str "abcd"

	END_TEST

	sub test_const( byref p as integer )
		CU_ASSERT_EQUAL( @p, 1234 )
	end sub

	sub test_byval( byref p as integer )
		CU_ASSERT_EQUAL( @p, 5678 )
	end sub

	sub test_str( byref p as zstring ptr )
		CU_ASSERT_EQUAL( @p, @"abcd" )
	end sub

END_SUITE
