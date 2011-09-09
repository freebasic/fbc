# include "fbcu.bi"

namespace fbc_tests.ns.using_nested

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
	
	sub test_1 cdecl	
		CU_ASSERT_EQUAL( ns_c.foo, &hdeadbeef )
		CU_ASSERT_EQUAL( ns_c.inner.foo, &hdeadbeef )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using-nested")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace		