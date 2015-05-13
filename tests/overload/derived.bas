# include "fbcu.bi"

namespace fbc_tests.overloads.derived

type A
	as integer dummy
end type

type B extends A
end type

type C extends B
end type


namespace ResolveToBase
	function f overload( i as integer ) as integer
		function = &h1
	end function 

	function f overload( a as A ) as integer
		function = &hA
	end function

	function f overload( b as B ) as integer
		function = &hB
	end function 

	sub test cdecl( )
		dim as integer i
		CU_ASSERT( f( i ) = &h1 )

		dim as A xa
		CU_ASSERT( f( xa ) = &hA )

		dim as B xb
		CU_ASSERT( f( xb ) = &hB )

		'' There is no C overload, it should use the B one
		dim as C xc
		CU_ASSERT( f( xc ) = &hB )
	end sub
end namespace


namespace ResolveExact
	function f overload( i as integer ) as integer
		function = &h1
	end function 

	function f overload( a as A ) as integer
		function = &hA
	end function

	function f overload( b as B ) as integer
		function = &hB
	end function 

	function f overload( c as C ) as integer
		function = &hC
	end function 

	sub test cdecl( )
		dim as integer i
		CU_ASSERT( f( i ) = &h1 )

		dim as A xa
		CU_ASSERT( f( xa ) = &hA )

		dim as B xb
		CU_ASSERT( f( xb ) = &hB )

		dim as C xc
		CU_ASSERT( f( xc ) = &hC )
	end sub
end namespace


private sub ctor( ) constructor
	fbcu.add_suite( "tests/overload/derived" )
	fbcu.add_test( "Derived can resolve to Base in overloading", @ResolveToBase.test )
	fbcu.add_test( "Derived resolve to themselves when possible", @ResolveExact.test )
end sub

end namespace
