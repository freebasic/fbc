# include "fbcu.bi"

#define expr(n) ((n - (n - (n + (n - (n + 1))))))

namespace fbc_tests.optimizations.addsub

sub test_accum_addsub cdecl( )
	dim as integer n = 0
	CU_ASSERT_EQUAL( expr(0), -1 )
	CU_ASSERT_EQUAL( expr(n), expr(0) )

	dim as integer i = 0
	CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
	i = 10
	CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
	i = -99
	CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.optimizations.addsub")
	fbcu.add_test( "Optimizing constant folding in nested add/subtract expressions", @test_accum_addsub )
end sub

end namespace
