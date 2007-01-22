# include "fbcu.bi"

namespace fbc_tests.ns.using_reimp2

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

	sub test_1 cdecl
		CU_ASSERT_EQUAL( ns_b.foo, 1 )
	end sub	

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using_reimp2")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace