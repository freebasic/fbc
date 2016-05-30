# include once "fbcu.bi"

namespace fbc_tests.expressions.addrof_anon

type PodUdt
	as integer a, b
end type

type CtorUdt
	as integer a, b
	declare constructor( )
end type

constructor CtorUdt( )
	a = 11
	b = 22
end constructor

private sub test cdecl( )
	CU_ASSERT( (@type<PodUdt>(111, 222))->a = 111 )
	CU_ASSERT( (@type<PodUdt>(111, 222))->b = 222 )
	CU_ASSERT( @type<PodUdt>(1, 2) <> @type<PodUdt>(3, 4))

	CU_ASSERT( (@CtorUdt( ))->a = 11 )
	CU_ASSERT( (@CtorUdt( ))->b = 22 )
	CU_ASSERT( @CtorUdt( ) <> @CtorUdt( ) )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.expressions.addrof-anon" )
	fbcu.add_test( "test", @test )
end sub

end namespace
