# include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using_nested )

	namespace ns_a
		dim as integer foo = &hdeadbeef
	end namespace
	
	namespace ns_b
		using ns_a
		namespace inner
			using ns_a
		end namespace
	end namespace
	
	namespace ns_c
		using ns_b
	end namespace
	
	TEST( all )
		CU_ASSERT_EQUAL( ns_c.foo, &hdeadbeef )
		CU_ASSERT_EQUAL( ns_c.inner.foo, &hdeadbeef )
	END_TEST
	
END_SUITE
