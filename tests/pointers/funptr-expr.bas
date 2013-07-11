# include "fbcu.bi"

namespace fbc_tests.pointers.funcptr_expr

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

sub testRvalueByref cdecl( )
	'' Compile-time -gen gcc regression test:
	'' The function pointer expression @s is passed BYREF here. Since it's
	'' an rvalue expression, the compiler will create a temp var and then
	'' pass that BYREF. This requires the @s expression to have a proper
	'' function pointer subtype symbol so the temp var can pick that up
	'' and be emitted with it properly when using the C backend.
	f2( @f1 )( )

	CU_ASSERT( f4( @f3 )( ) = 123 )
end sub

sub sub1( )
end sub

sub sub2( )
end sub

sub testSubtract cdecl( )
	CU_ASSERT( (@sub1 - @sub2) <> 0 )
	CU_ASSERT( (@sub2 - @sub1) <> 0 )

	dim as sub( ) p1 = @sub1, p2 = @sub2
	CU_ASSERT( (@sub1 - @sub2) = (p1 - p2) )
	CU_ASSERT( (@sub2 - @sub1) = (p2 - p1) )
end sub

private sub ctor () constructor
	fbcu.add_suite( "tests/pointers/funcptr-expr" )
	fbcu.add_test( "@proc passed to BYREF param", @testRvalueByref )
	fbcu.add_test( "procptr expr/var subtraction", @testSubtract )
end sub

end namespace
