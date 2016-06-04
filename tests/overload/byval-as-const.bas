# include "fbcu.bi"

namespace fbc_tests.overload_.byval_as_const

namespace udtInheritance
	type T1
		i as integer
	end type

	type T2 extends T1
	end type

	function f overload( byval x1 as const T1 ) as string : function = "1" : end function
	function f overload( byval x2 as const T2 ) as string : function = "2" : end function

	sub test cdecl( )
		dim x1 as T1
		dim x2 as T2
		CU_ASSERT( f( x1 ) = "1" )
		CU_ASSERT( f( x2 ) = "2" )

		dim cx1 as const T1 = (1)
		dim cx2 as const T2 = ((2))
		CU_ASSERT( f( cx1 ) = "1" )
		CU_ASSERT( f( cx2 ) = "2" )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.overload.byval-as-const" )
	fbcu.add_test( "UDTs with inheritance", @udtInheritance.test )
end sub

end namespace
