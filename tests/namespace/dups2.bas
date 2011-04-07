# include "fbcu.bi"

dim shared as integer foo = -1

namespace fbc_tests.ns.dups2

	namespace ns1
		dim as integer foo = 1
	end namespace
	
	namespace ns2
		dim as integer foo = 2
		function fun overload( i as integer ) as integer
			function = 0
		end function
	end namespace
	
	namespace ns3
		using ns1
		using ns2
		dim as integer foo = 3
		function fun overload( i as integer ) as integer
			function = -1234
		end function
	end namespace	
	
	namespace ns3
		sub test
			CU_ASSERT_EQUAL( foo, 3 )
			CU_ASSERT_EQUAL( ns3.foo, 3 )
			CU_ASSERT_EQUAL( .foo, -1 )
		end sub
	end namespace
		
	sub test_1 cdecl
		ns3.test
		CU_ASSERT_EQUAL( ns3.fun(0), -1234 )
	end sub
		
	sub test_2 cdecl
		using ns3
		dim as integer foo = 4
		CU_ASSERT_EQUAL( foo, 4 )
		CU_ASSERT_EQUAL( .foo, -1 )
		CU_ASSERT_EQUAL( ns3.foo, 3 )
		CU_ASSERT_EQUAL( ns3.fun(0), -1234 )
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.dups2")
		fbcu.add_test("#1", @test_1)
		fbcu.add_test("#2", @test_2)
		
	end sub

end namespace