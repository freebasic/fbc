#include "fbcu.bi"

namespace fbc_tests.optimizations.logic1
	
	sub test cdecl( )
		if( 0 )then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test2 cdecl( )
		if( 1 and 0 )then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test3 cdecl( )
		if( 1 > 0 and 0 ) then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test4 cdecl( )
		dim as string source = "this is a test"
		if len(source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(source) > 0 ) and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	sub test5 cdecl( )
		dim A as string
		A = "test 1..2..3..4...5..6...7..8...9..10"
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
	
	sub test6 cdecl( )
		dim as integer a
		if ( a + 0 ) then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.optimizations.logic1")
		fbcu.add_test("1", @test)
		fbcu.add_test("2", @test2)
		fbcu.add_test("3", @test3)
		fbcu.add_test("4", @test4)
		fbcu.add_test("5", @test5)
		fbcu.add_test("6", @test6)
	
	end sub
	
end namespace
	