#include "fbcu.bi"

namespace fbc_tests.optimizations.logic2
	
	sub test cdecl( )
		dim as string source = "this is a test"
		
		if instr("huh", source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(source) > 0 ) and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if len(source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test2 cdecl( )
		if left("huh", 3) > "" and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if sin(3.14) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test3 cdecl( )
		dim A as string
		A = "test 1..2..3..4...5..6...7..8...9..10"
		' print len(A) > 15 and 0  ' when this line is uncommented this part of the test succeeds,
		if len(A) > 15 and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(A) > 15 ) and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.optimizations.logic2")
		fbcu.add_test("1", @test)
		fbcu.add_test("2", @test2)
		fbcu.add_test("3", @test3)
	
	end sub
	
end namespace
