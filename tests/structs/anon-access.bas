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

type PodUdtAlias as PodUdt
type CtorUdtAlias as CtorUdt

sub test cdecl( )
	CU_ASSERT( (type<PodUdt>( 123 )).i = 123 )
	CU_ASSERT( type<PodUdt>( 123 ).i = 123 )

	CU_ASSERT( (type<PodUdtAlias>( 123 )).i = 123 )
	CU_ASSERT( type<PodUdtAlias>( 123 ).i = 123 )

	CU_ASSERT( (CtorUdt( )).a = 123 )
	CU_ASSERT( (CtorUdt( )).b = 456 )
	CU_ASSERT( CtorUdt( ).a = 123 )
	CU_ASSERT( CtorUdt( ).b = 456 )
	CU_ASSERT( (type<CtorUdt>( )).a = 123 )
	CU_ASSERT( (type<CtorUdt>( )).b = 456 )
	CU_ASSERT( type<CtorUdt>( ).a = 123 )
	CU_ASSERT( type<CtorUdt>( ).b = 456 )

	CU_ASSERT( (CtorUdtAlias( )).a = 123 )
	CU_ASSERT( (CtorUdtAlias( )).b = 456 )
	CU_ASSERT( CtorUdtAlias( ).a = 123 )
	CU_ASSERT( CtorUdtAlias( ).b = 456 )
	CU_ASSERT( (type<CtorUdtAlias>( )).a = 123 )
	CU_ASSERT( (type<CtorUdtAlias>( )).b = 456 )
	CU_ASSERT( type<CtorUdtAlias>( ).a = 123 )
	CU_ASSERT( type<CtorUdtAlias>( ).b = 456 )
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

namespace atBeginOfStatement
	dim shared globali as integer

	type UDT
		i as integer = 123
		declare function getI() as integer
		declare sub copyToGlobal()
	end type

	function UDT.getI() as integer
		return i
	end function

	sub UDT.copyToGlobal()
		globali = i
	end sub

	private sub test cdecl( )
		CU_ASSERT( UDT().getI() = 123 )
		CU_ASSERT( type<UDT>().getI() = 123 )

		globali = 0
		UDT().copyToGlobal()
		CU_ASSERT( globali = 123 )

		globali = 0
		(UDT()).copyToGlobal()
		CU_ASSERT( globali = 123 )

		globali = 0
		type<UDT>().copyToGlobal()
		CU_ASSERT( globali = 123 )

		globali = 0
		(type<UDT>()).copyToGlobal()
		CU_ASSERT( globali = 123 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.anon-access" )
	fbcu.add_test( "#3538470", @test3538470 )
	fbcu.add_test( "test", @test )
	fbcu.add_test( "atBeginOfStatement", @atBeginOfStatement.test )
end sub

end namespace
