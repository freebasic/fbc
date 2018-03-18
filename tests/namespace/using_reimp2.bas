#include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using_reimp2 )

	namespace ns_a		
	end namespace
	
	namespace ns_b
		dim as integer bar = 2
	end namespace
	
	namespace ns_b
		using ns_a
	end namespace
	
	namespace ns_c
		dim as integer foo = 1
	end namespace

	namespace ns_a
		using ns_c
	end namespace

	TEST( all )
		CU_ASSERT_EQUAL( ns_b.foo, 1 )
	END_TEST

END_SUITE
