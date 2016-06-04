#include "fbcu.bi"
#include "crt.bi"

namespace fbc_tests.crt.varargs

private sub test cdecl( )
	'' To test varargs even under -gen gcc, when other vararg tests are
	'' disabled due to va_first() being disallowed in -gen gcc
	const BUFFER_SIZE = 128
	dim as zstring * BUFFER_SIZE z
	dim as long i = 123
	dim as zstring ptr pz = @"hello"
	snprintf( @z, BUFFER_SIZE, "%i %s %i", i, pz, clng( 456 ) )
	CU_ASSERT( z = "123 hello 456" )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.crt.varargs" )
	fbcu.add_test( "test", @test )
end sub

end namespace
