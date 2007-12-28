# include "fbcu.bi"

namespace fbc_tests.ns.using2

	namespace ns1
		dim as integer foo = 1
	end namespace
	
	namespace ns2
		using ns1
		dim as integer foo = 2
		dim as integer bar = 1234
	end namespace
	
	namespace ns3
		using ns2
		dim as integer foo = 3
	end namespace
	
	sub test_1 cdecl
		using ns3
		dim as integer foo = 4
		
		CU_ASSERT_EQUAL( ns3.bar, 1234 )
	end sub	

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using2")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace