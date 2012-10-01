# include "fbcu.bi"

namespace fbc_tests.dim_.udt_init_any

dim shared as integer ctor_count

type T
	declare constructor( )
	as integer i
end type

constructor T( )
	ctor_count += 1
end constructor

sub test cdecl( )
	CU_ASSERT( ctor_count = 0 )
	scope
		dim as T x = any
		CU_ASSERT( ctor_count = 0 )
		x.constructor( )
		CU_ASSERT( ctor_count = 1 )
	end scope
	CU_ASSERT( ctor_count = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/udt-init-any")
	fbcu.add_test( "'= ANY' UDT variable initializer", @test )
end sub

end namespace
