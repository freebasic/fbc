#include "fbcu.bi"

namespace fbc_tests.dim_.dynamic_unknowndimensions

namespace uboundDimensionCount
	'' With the compiler tracking the dimension count of dynamic arrays
	'' at compile-time, check whether it doesn't get confused with
	'' allocated & unallocated dynamic arrays.
	dim shared array1() as integer

	private sub redimIt( )
		redim array1(0 to 0, 0 to 0, 0 to 0)
	end sub

	private sub test cdecl( )
		'' We've seen array1() being REDIM'ed to 3 dimensions, but at
		'' runtime it's unallocated here still.
		CU_ASSERT( ubound( array1, 0 ) = 0 )

		redimIt( )

		'' Now the allocated array has 3 dimensions
		CU_ASSERT( ubound( array1, 0 ) = 3 )

		dim array2() as integer
		CU_ASSERT( ubound( array2, 0 ) = 0 )

		redim array2(0 to 1)
		CU_ASSERT( ubound( array2, 0 ) = 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/dynamic-unknowndimensions" )
	fbcu.add_test( "ubound() dimension count", @uboundDimensionCount.test )
end sub

end namespace
