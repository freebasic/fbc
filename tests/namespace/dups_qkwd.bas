#include "fbcunit.bi"

SUITE( fbc_tests.namespace_.dups_qkwd )
	namespace ns_a
		type line
			x as integer
		end type
	
		const line = 1234
			
		sub do_test( byref l as line )
			CU_ASSERT_EQUAL( l.x, 5678 )
		end sub
	
	end namespace
	
	TEST( test1 )
		dim as ns_a.line l = ( 5678 )
		ns_a.do_test( l )
	END_TEST
	
	namespace ns_1
		type line
			y as integer
		end type
	
	end namespace
	
	namespace ns_2
		using ns_1
		
		sub do_test( byref l as line )
			CU_ASSERT_EQUAL( l.y, -5678 )
		end sub
	end namespace
	
	TEST( test2 )
		dim as ns_1.line l = ( -5678 )
		ns_2.do_test( l )
	END_TEST
	
END_SUITE
