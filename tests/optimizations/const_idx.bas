# include "fbcu.bi"

namespace fbc_tests.optimizations.constant_index

private sub test1 cdecl( )
	dim as integer x = 0, brd(8, 8, 9)
	cu_assert_equal( @brd(1, 0, 0), @brd(1, x, 0) )
	cu_assert_equal( @brd(1, 0, 0), @brd(1, 0, x) )
	cu_assert_equal( @brd(1, 0, 0), @brd(1, x, x) )
end sub

private sub test2 cdecl( )
	dim as integer array(0 to 0)
	dim as integer i = -2

	'' Standalone this expression works fine
	CU_ASSERT( (i+2)*(-1) = 0 )

	'' but when inside an IDX, it caused the IDX to be misoptimized
	CU_ASSERT( @array((i+2)*(-1)) = @array(0) )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/const_idx" )
	fbcu.add_test( "test1", @test1 )
	fbcu.add_test( "test2", @test2 )
end sub

end namespace
