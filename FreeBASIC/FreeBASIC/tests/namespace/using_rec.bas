# include "fbcu.bi"

namespace fbc_tests.ns.using_rec

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
	
	sub test_1 cdecl
		using ns_a
		CU_ASSERT_EQUAL( bar, 1234 )
	end sub	

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using_rec")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace