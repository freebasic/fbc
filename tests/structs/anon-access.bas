# include "fbcu.bi"

namespace fbc_tests.structs.anon_access

type UDT
	as integer a, b
	declare constructor( )
end type

constructor UDT( )
	a = 123
	b = 456
end constructor

private sub test3538470 cdecl( )
	'' Regression test for bug #3538470
	'' This used to trigger an out-of-bounds array access in fbc
	dim x as integer

	CU_ASSERT( x = 0 )
	x = (UDT( )).a
	CU_ASSERT( x = 123 )
	CU_ASSERT( (UDT( )).a = 123 )
	CU_ASSERT( 123 = (UDT( )).a )

	x = (UDT( )).b
	CU_ASSERT( x = 456 )
	CU_ASSERT( (UDT( )).b = 456 )
	CU_ASSERT( 456 = (UDT( )).b )

	x = (type<UDT>( )).a
	CU_ASSERT( x = 123 )
	CU_ASSERT( (type<UDT>( )).a = 123 )
	CU_ASSERT( 123 = (type<UDT>( )).a )

	x = (type<UDT>( )).b
	CU_ASSERT( x = 456 )
	CU_ASSERT( (type<UDT>( )).b = 456 )
	CU_ASSERT( 456 = (type<UDT>( )).b )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/anon-access" )
	fbcu.add_test( "#3538470", @test3538470 )
end sub

end namespace
