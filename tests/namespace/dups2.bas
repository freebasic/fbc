#include "fbcunit.bi"

dim shared as integer foo = -1

SUITE( fbc_tests.namespace_.dups2 )

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
		sub dotest
			CU_ASSERT_EQUAL( foo, 3 )
			CU_ASSERT_EQUAL( ns3.foo, 3 )
			CU_ASSERT_EQUAL( .foo, -1 )
		end sub
	end namespace
		
	TEST( named )
		ns3.dotest
		CU_ASSERT_EQUAL( ns3.fun(0), -1234 )
	END_TEST
		
	TEST( using_ )
		using ns3
		dim as integer foo = 4
		CU_ASSERT_EQUAL( foo, 4 )
		CU_ASSERT_EQUAL( .foo, -1 )
		CU_ASSERT_EQUAL( ns3.foo, 3 )
		CU_ASSERT_EQUAL( ns3.fun(0), -1234 )
	END_TEST

END_SUITE
