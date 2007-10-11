# include "fbcu.bi"

namespace fbc_tests.ns.using_reimp

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

	sub test_1 cdecl
		CU_ASSERT_EQUAL( bar, 2 )
	end sub	

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using_reimp")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace