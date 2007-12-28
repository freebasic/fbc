# include "fbcu.bi"

namespace ns_a
	dim as integer bar = 1234
	dim as integer baz = 5678
end namespace

		using ns_a

namespace fbc_tests.ns.using_

	namespace ns_b
		using ns_a
	end namespace
	
	sub test_1 cdecl
		CU_ASSERT_EQUAL( .bar, 1234 )
		CU_ASSERT_EQUAL( ns_b.baz, 5678 )
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace