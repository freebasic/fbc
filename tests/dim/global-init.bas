# include "fbcu.bi"

namespace fbc_tests.dim_.global_init

'' -gen gcc regression test: This shouldn't trigger a gcc warning.
dim shared a as integer
dim shared b as integer = @a

sub test cdecl( )
	CU_ASSERT( b = @a )
end sub

sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.dim.global-init" )
	fbcu.add_test( "test", @test )
end sub

end namespace
