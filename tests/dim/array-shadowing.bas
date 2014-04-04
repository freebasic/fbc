# include "fbcu.bi"

namespace fbc_tests.dim_.array_shadowing

#macro expectbounds( l, u )
	CU_ASSERT( lbound( x ) = l )
	CU_ASSERT( ubound( x ) = u )
#endmacro

private sub testEmptyDynamic cdecl( )
	dim x() as integer
	expectbounds( 0, -1 )

	scope
		expectbounds( 0, -1 )
		dim x() as integer
		expectbounds( 0, -1 )
		redim x(1 to 1)
		expectbounds( 1, 1 )
	end scope
	expectbounds( 0, -1 )

	scope
		expectbounds( 0, -1 )
		dim x(1 to 1) as integer
		expectbounds( 1, 1 )
	end scope
	expectbounds( 0, -1 )

	'' This redims, instead of shadowing:
	scope
		expectbounds( 0, -1 )
		redim x(1 to 1) as integer
		expectbounds( 1, 1 )
	end scope
	expectbounds( 1, 1 )
end sub

private sub testFilledDynamic cdecl( )
	redim x(1 to 1) as integer
	expectbounds( 1, 1 )

	scope
		expectbounds( 1, 1 )
		dim x() as integer
		expectbounds( 0, -1 )
		redim x(2 to 2)
		expectbounds( 2, 2 )
	end scope
	expectbounds( 1, 1 )

	scope
		expectbounds( 1, 1 )
		dim x(2 to 2) as integer
		expectbounds( 2, 2 )
	end scope
	expectbounds( 1, 1 )

	'' This redims, instead of shadowing:
	scope
		expectbounds( 1, 1 )
		redim x(2 to 2) as integer
		expectbounds( 2, 2 )
	end scope
	expectbounds( 2, 2 )
end sub

private sub testFixedSize cdecl( )
	dim x(1 to 1) as integer
	expectbounds( 1, 1 )

	scope
		expectbounds( 1, 1 )
		dim x() as integer
		expectbounds( 0, -1 )
		redim x(2 to 2)
		expectbounds( 2, 2 )
	end scope
	expectbounds( 1, 1 )

	scope
		expectbounds( 1, 1 )
		dim x(2 to 2) as integer
		expectbounds( 2, 2 )
	end scope
	expectbounds( 1, 1 )

	scope
		expectbounds( 1, 1 )
		redim x(2 to 2) as integer
		expectbounds( 2, 2 )
	end scope
	expectbounds( 1, 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/array-shadowing" )
	fbcu.add_test( "empty dynamic array", @testEmptyDynamic )
	fbcu.add_test( "filled dynamic array", @testFilledDynamic )
	fbcu.add_test( "fixed-size array", @testFixedSize )
end sub

end namespace
