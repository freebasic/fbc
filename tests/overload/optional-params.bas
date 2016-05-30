# include "fbcu.bi"

namespace fbc_tests.overloads.optional_params

namespace testRegression1
	function f overload( byval i as integer, byref s as string ) as integer
		function = 1
	end function
	function f overload( byval i as integer, byval j as integer = 0, byval k as integer = 0, byval l as integer = 0, byval m as integer = 0, byval n as integer = 0 ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 0, "hi"          ) = 1 )
		CU_ASSERT( f( 0                ) = 2 )
		CU_ASSERT( f( 0, 0             ) = 2 )
		CU_ASSERT( f( 0, 0, 0          ) = 2 )
		CU_ASSERT( f( 0, 0, 0, 0       ) = 2 )
		CU_ASSERT( f( 0, 0, 0, 0, 0    ) = 2 )
		CU_ASSERT( f( 0, 0, 0, 0, 0, 0 ) = 2 )
	end sub
end namespace

namespace testRegression2
	function f overload( p1 as ulongint, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
		function = 1
	end function
	function f overload( p1 as ulongint, p2 as string ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 1,   2       ) = 1 )
		CU_ASSERT( f( 1,   2, 3    ) = 1 )
		CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
		CU_ASSERT( f( 1, "2"       ) = 2 )
	end sub
end namespace

namespace testRegression3
	function f overload( p1 as integer, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
		function = 1
	end function
	function f overload( p1 as integer, p2 as string ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 1,   2       ) = 1 )
		CU_ASSERT( f( 1,   2, 3    ) = 1 )
		CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
		CU_ASSERT( f( 1, "2"       ) = 2 )
	end sub
end namespace

namespace testRegression4
	function f overload( p1 as integer, p2 as integer, p3 as integer = 0, p4 as integer = 0 ) as integer
		function = 1
	end function
	function f overload( p1 as integer, p2 as string, p3 as integer = 0, p4 as integer = 0 ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 1,   2       ) = 1 )
		CU_ASSERT( f( 1,   2, 3    ) = 1 )
		CU_ASSERT( f( 1,   2, 3, 4 ) = 1 )
		CU_ASSERT( f( 1, "2"       ) = 2 )
		CU_ASSERT( f( 1, "2", 3    ) = 2 )
		CU_ASSERT( f( 1, "2", 3, 4 ) = 2 )
	end sub
end namespace

namespace testNoParams1
	function f overload( ) as integer
		function = 1
	end function
	function f overload( p1 as integer = 0 ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 0 ) = 2 )
	end sub
end namespace

namespace testNoParams2
	function f overload( p1 as integer = 0 ) as integer
		function = 1
	end function
	function f overload( ) as integer
		function = 2
	end function

	sub test cdecl( )
		CU_ASSERT( f( 0 ) = 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.overload.optional-params" )
	fbcu.add_test( "regression test 1", @testRegression1.test )
	fbcu.add_test( "regression test 2", @testRegression2.test )
	fbcu.add_test( "no params 1", @testNoParams1.test )
	fbcu.add_test( "no params 2", @testNoParams2.test )
end sub

end namespace
