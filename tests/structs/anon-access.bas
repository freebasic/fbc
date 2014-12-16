# include "fbcu.bi"

namespace fbc_tests.structs.anon_access

type PodUdt
	i as integer
end type

type CtorUdt
	as integer a, b
	declare constructor( )
end type

constructor CtorUdt( )
	a = 123
	b = 456
end constructor

sub test cdecl( )
	CU_ASSERT( (type<PodUdt>( 123 )).i = 123 )
	CU_ASSERT( type<PodUdt>( 123 ).i = 123 )
end sub

private sub test3538470 cdecl( )
	'' Regression test for bug #3538470
	'' This used to trigger an out-of-bounds array access in fbc
	dim x as integer

	CU_ASSERT( x = 0 )
	x = (CtorUdt( )).a
	CU_ASSERT( x = 123 )
	CU_ASSERT( (CtorUdt( )).a = 123 )
	CU_ASSERT( 123 = (CtorUdt( )).a )

	x = (CtorUdt( )).b
	CU_ASSERT( x = 456 )
	CU_ASSERT( (CtorUdt( )).b = 456 )
	CU_ASSERT( 456 = (CtorUdt( )).b )

	x = (type<CtorUdt>( )).a
	CU_ASSERT( x = 123 )
	CU_ASSERT( (type<CtorUdt>( )).a = 123 )
	CU_ASSERT( 123 = (type<CtorUdt>( )).a )

	x = (type<CtorUdt>( )).b
	CU_ASSERT( x = 456 )
	CU_ASSERT( (type<CtorUdt>( )).b = 456 )
	CU_ASSERT( 456 = (type<CtorUdt>( )).b )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/anon-access" )
	fbcu.add_test( "#3538470", @test3538470 )
	fbcu.add_test( "test", @test )
end sub

end namespace
