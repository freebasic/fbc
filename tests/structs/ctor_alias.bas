# include "fbcu.bi"

namespace fbc_tests.structs.ctor_alias

dim shared as integer inits, cleanups

type UDT
	i as integer

	declare sub init alias "init"( )
	declare constructor alias "init"( )

	declare sub cleanup alias "cleanup"( )
	declare destructor alias "cleanup"( )
end type

sub UDT.init( )
	inits += 1
end sub

sub UDT.cleanup( )
	cleanups += 1
end sub

private sub test cdecl( )
	CU_ASSERT( inits = 0 )
	CU_ASSERT( cleanups = 0 )

	scope
		dim x as UDT

		CU_ASSERT( inits = 1 )
		CU_ASSERT( cleanups = 0 )
	end scope

	CU_ASSERT( inits = 1 )
	CU_ASSERT( cleanups = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/ctor-alias" )
	fbcu.add_test( "test", @test )
end sub

end namespace
