# include "fbcu.bi"

namespace fbc_tests.swp.sidefx

dim shared as integer f1_calls
private function f1( ) as integer ptr
	static as integer i = 1
	f1_calls += 1
	return @i
end function

dim shared as integer f2_calls
private function f2( ) as integer ptr
	static as integer i = 1
	f2_calls += 1
	return @i
end function

sub testDerefs cdecl( )
	dim as integer a = 0

	CU_ASSERT( f1_calls = 0 )
	swap a, *f1( )
	CU_ASSERT( f1_calls = 1 )
	CU_ASSERT( a = 1 )

	swap *f1( ), a
	CU_ASSERT( f1_calls = 2 )
	CU_ASSERT( a = 0 )

	swap *f1( ), *f2( )
	CU_ASSERT( f1_calls = 3 )
	CU_ASSERT( f2_calls = 1 )
end sub

dim shared as integer returnIndex_calls
private function returnIndex() as integer
	returnIndex_calls += 1
	return 1
end function

sub testArrays cdecl( )
	dim as integer array(0 to 1)
	CU_ASSERT( returnIndex_calls = 0 )
	swap array(returnIndex( )), array(returnIndex( ))
	CU_ASSERT( returnIndex_calls = 2 )
end sub

type Udt
	as integer a, b, c, d, e, f
end type

dim shared as integer returnUdt_calls
private function returnUdt( ) as Udt
	returnUdt_calls += 1
	return type( 1, 2, 3, 4, 5, 6 )
end function

sub testResultUdtField cdecl( )
	'' Should this be allowed in the first place?
	'' SWAP on function results doesn't make sense,
	''   func() = foo
	'' is disallowed too...

	dim as integer a = 0

	CU_ASSERT( returnUdt_calls = 0 )
	swap returnUdt( ).a, a
	CU_ASSERT( returnUdt_calls = 1 )
	CU_ASSERT( a = 1 )

	swap a, returnUdt( ).b
	CU_ASSERT( returnUdt_calls = 2 )
	CU_ASSERT( a = 2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fb_tests.swap.sidefx" )
	fbcu.add_test( "SWAP on *function()", @testDerefs )
	fbcu.add_test( "SWAP on array(function())", @testArrays )
	fbcu.add_test( "SWAP on function().field", @testResultUdtField )
end sub

end namespace
