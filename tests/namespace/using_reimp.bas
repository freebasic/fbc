# include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using_reimp )

	namespace ns_a
		dim as integer foo = 1
	end namespace
	
	namespace ns_b
		dim as integer bar = 2
	end namespace
	
		using ns_b
	
	namespace ns_b
		using ns_a
	end namespace

	TEST( all )
		CU_ASSERT_EQUAL( bar, 2 )
	END_TEST

END_SUITE
