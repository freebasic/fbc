#include "fbcunit.bi"
#include "crt.bi"

SUITE( fbc_tests.crt.varargs )

	TEST( args )

		'' To test varargs even under -gen gcc, when other vararg tests are
		'' disabled due to va_first() being disallowed in -gen gcc
		const BUFFER_SIZE = 128
		dim as zstring * BUFFER_SIZE z
		dim as long i = 123
		dim as zstring ptr pz = @"hello"
		snprintf( @z, BUFFER_SIZE, "%i %s %i", i, pz, clng( 456 ) )
		CU_ASSERT( z = "123 hello 456" )

	END_TEST

END_SUITE
