# include "fbcu.bi"

namespace fbc_tests.overload_.integers

namespace regressionTestBug716
	function f1 overload( i as short   ) as string : function = "f1 short"   : end function
	function f1 overload( i as long    ) as string : function = "f1 long"    : end function
	function f1 overload( i as longint ) as string : function = "f1 longint" : end function

	function f2 overload( i as short   ) as string : function = "f2 short"   : end function
	function f2 overload( i as longint ) as string : function = "f2 longint" : end function

	sub test cdecl( )
		dim xshort as short
		dim xlong as long
		dim xlongint as longint
		dim xinteger as integer

		CU_ASSERT( f1( xshort   ) = "f1 short"   )
		CU_ASSERT( f1( xlong    ) = "f1 long"    )
		CU_ASSERT( f1( xlongint ) = "f1 longint" )
#ifdef __FB_64BIT__
		CU_ASSERT( f1( xinteger ) = "f1 longint" )
#else
		CU_ASSERT( f1( xinteger ) = "f1 long"    )
#endif

		CU_ASSERT( f2( xshort   ) = "f2 short"   )
		CU_ASSERT( f2( xlong    ) = "f2 longint" )
		CU_ASSERT( f2( xlongint ) = "f2 longint" )
		CU_ASSERT( f2( xinteger ) = "f2 longint" )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/overload/integers" )
	fbcu.add_test( "regression test for ubg #716", @regressionTestBug716.test )
end sub

end namespace
