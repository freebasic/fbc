# include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using_rec )

	namespace ns_a
		dim as integer foo = 1
	end namespace
	
	namespace ns_b
		using ns_a
		dim as integer foo = 2
	end namespace
	
	namespace ns_c
		using ns_b
		dim as integer foo = 3
	end namespace
	
	namespace ns_a
		using ns_c
		dim as integer bar = 1234
	end namespace
	
	TEST( all )
		using ns_a
		CU_ASSERT_EQUAL( bar, 1234 )
	END_TEST

END_SUITE
