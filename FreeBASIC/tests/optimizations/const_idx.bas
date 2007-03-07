# include "fbcu.bi"

namespace fbc_tests.optimizations.constant_index
	
	sub test_array cdecl( )
		
		dim as integer x, brd(8, 8, 9)
		assert( @brd(1, 0, 0) = @brd(1, x, 0) )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.optimizations.constant_index")
		fbcu.add_test("mixed constant folding", @test_array)
		
	end sub

end namespace
