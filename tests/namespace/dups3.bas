#include "fbcunit.bi"

dim shared as integer dups3_foo = -1

'' regression test for sf.net 581
'' reverted logic removal in 2d263e9

	namespace dups3_ns1
		dim as integer dups3_foo = 1
	end namespace
	
	namespace dups3_ns2
		dim as integer dups3_foo = 2
		function fun overload( i as integer ) as integer
			function = 0
		end function
	end namespace
	
	namespace dups3_ns3
		using dups3_ns1
		using dups3_ns2
		dim as integer dups3_foo = 3
		function fun overload( i as integer ) as integer
			function = -1234
		end function
	end namespace	
	
	namespace dups3_ns3
		sub dotest
			CU_ASSERT_EQUAL( dups3_foo, 3 )
			CU_ASSERT_EQUAL( dups3_ns3.dups3_foo, 3 )
			CU_ASSERT_EQUAL( .dups3_foo, -1 )
		end sub
	end namespace
		
	private sub dups3_named
		dups3_ns3.dotest
		CU_ASSERT_EQUAL( dups3_ns3.fun(0), -1234 )
	end sub
		
	private sub dups3_using
		using dups3_ns3
		dim as integer dups3_foo = 4
		CU_ASSERT_EQUAL( dups3_foo, 4 )
		CU_ASSERT_EQUAL( .dups3_foo, -1 )
		CU_ASSERT_EQUAL( dups3_ns3.dups3_foo, 3 )
		CU_ASSERT_EQUAL( dups3_ns3.fun(0), -1234 )
	end sub

SUITE( fbc_tests.namespace_.dups3 )
	TEST( named )
		dups3_named
	END_TEST
	TEST( using_ )
		dups3_using
	END_TEST

END_SUITE
