# include "fbcu.bi"

namespace fbc_tests.const_.cast_const_away

sub test cdecl( )
	dim i as integer = 456
	dim pci as const integer ptr = @i

	CU_ASSERT( *pci = 456 )

	*cptr( integer ptr, pci ) = 123

	CU_ASSERT( *pci = 123 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/const/cast-const-away" )
	fbcu.add_test( "1", @test )
end sub

end namespace
