# include "fbcu.bi"

namespace fbc_tests.optimizations.constant_index
	
	sub test_array cdecl( )
		
		dim as integer x = 0, brd(8, 8, 9)
		cu_assert_equal( @brd(1, 0, 0), @brd(1, x, 0) )
		cu_assert_equal( @brd(1, 0, 0), @brd(1, 0, x) )
		cu_assert_equal( @brd(1, 0, 0), @brd(1, x, x) )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.optimizations.constant_index")
		fbcu.add_test("Array index const folding", @test_array)
		
	end sub

end namespace
