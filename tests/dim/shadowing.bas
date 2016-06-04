# include "fbcu.bi"

namespace fbc_tests.dim_.shadowing

#macro expectbounds( l, u )
	CU_ASSERT( lbound( x ) = l )
	CU_ASSERT( ubound( x ) = u )
#endmacro

private sub testEmptyDynamicArray cdecl( )
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

private sub testFilledDynamicArray cdecl( )
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

private sub testFixedSizeArray cdecl( )
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

namespace dimImplicitThisField
	type UDT
		i as integer
		array(0 to 1) as integer

		declare function f1( ) as integer ptr
		declare function f2( ) as integer ptr
	end type

	function UDT.f1( ) as integer ptr
		dim i as integer
		function = @i
	end function

	function UDT.f2( ) as integer ptr
		dim array(0 to 1) as integer
		function = @array(0)
	end function

	private sub test cdecl( )
		dim x as UDT
		CU_ASSERT( @x.i <> x.f1( ) )
		CU_ASSERT( @x.array(0) <> x.f2( ) )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.dim.shadowing" )
	fbcu.add_test( "empty dynamic array", @testEmptyDynamicArray )
	fbcu.add_test( "filled dynamic array", @testFilledDynamicArray )
	fbcu.add_test( "fixed-size array", @testFixedSizeArray )
	fbcu.add_test( "dim shadowing implicit THIS field", @dimImplicitThisField.test )
end sub

end namespace
