#include "fbcunit.bi"

SUITE( fbc_tests.pointers.funptr_expr )

	sub f1( )
	end sub

	function f2( byref p as sub( ) ) as sub( )
		return p
	end function

	function f3( ) as integer
		function = 123
	end function

	function f4( byref p as function( ) as integer ) as function( ) as integer
		function = p
	end function

	'' proc passed to BYREF param
	TEST( RvalueByref )
		'' Compile-time -gen gcc regression test:
		'' The function pointer expression @s is passed BYREF here. Since it's
		'' an rvalue expression, the compiler will create a temp var and then
		'' pass that BYREF. This requires the @s expression to have a proper
		'' function pointer subtype symbol so the temp var can pick that up
		'' and be emitted with it properly when using the C backend.
		f2( @f1 )( )

		CU_ASSERT( f4( @f3 )( ) = 123 )
	END_TEST

END_SUITE
