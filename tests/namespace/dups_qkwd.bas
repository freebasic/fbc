# include "fbcu.bi"

namespace fbc_tests.ns.dups_qkwd
	namespace ns_a
		type line
			x as integer
		end type
	
		const line = 1234
			
		sub do_test( byref l as line )
			CU_ASSERT_EQUAL( l.x, 5678 )
		end sub
	
	end namespace
	
	sub test_1 cdecl
		dim as ns_a.line l = ( 5678 )
		ns_a.do_test( l )
	end sub
	
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
	
	sub test_2 cdecl
		dim as ns_1.line l = ( -5678 )
		ns_2.do_test( l )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.dups_qkwd")
		fbcu.add_test("#1", @test_1)
		fbcu.add_test("#2", @test_2)
		
	end sub
	
end namespace