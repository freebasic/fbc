# include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using2 )

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
	
	TEST( all )
		using ns3
		dim as integer foo = 4
		
		CU_ASSERT_EQUAL( ns3.bar, 1234 )
	END_TEST

END_SUITE
