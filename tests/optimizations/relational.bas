# include "fbcu.bi"

namespace fbc_tests.optimizations.relational

private sub test cdecl( )
	dim as integer a0, b0

	#macro checkNE0( expr )
		scope
			var result = (expr)
			CU_ASSERT( ((expr) <> 0) = result )
		end scope
	#endmacro

	checkNE0( a0 =  0 )
	checkNE0( a0 <> 0 )
	checkNE0( a0 <  0 )
	checkNE0( a0 <= 0 )
	checkNE0( a0 >  0 )
	checkNE0( a0 >= 0 )

	checkNE0( a0 =  b0 )
	checkNE0( a0 <> b0 )
	checkNE0( a0 <  b0 )
	checkNE0( a0 <= b0 )
	checkNE0( a0 >  b0 )
	checkNE0( a0 >= b0 )

	checkNE0( not a0  )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/relational" )
	fbcu.add_test( "test", @test )
end sub

end namespace
