#include "fbcunit.bi"

'' HACK: provide our own type
'' for va_list before including
'' crt/stdarg.bi

type va_list as cva_list
#define __crt_stdarg_bi__

#include "crt.bi"

SUITE( fbc_tests.crt.varargs )

	TEST( call_snprintf )

		'' To test varargs even under -gen gcc, when other vararg tests are
		'' disabled due to va_first() being disallowed in -gen gcc
		const BUFFER_SIZE = 128
		dim as zstring * BUFFER_SIZE z
		dim as long i = 123
		dim as zstring ptr pz = @"hello"
		snprintf( @z, BUFFER_SIZE, "%i %s %i", i, pz, clng( 456 ) )
		CU_ASSERT( z = "123 hello 456" )

	END_TEST

	sub call_vsprintf_proc cdecl( byval z as zstring ptr, fmt as zstring ptr, ... )
		dim as cva_list args = any
		cva_start( args, fmt )
		#ifndef vsprintf
			CU_FAIL( snprintf not available for this target )
		#else
			vsprintf( z, fmt, args )
		#endif

		cva_end( args )
	end sub

	TEST( call_vsprintf )

		dim z as zstring * 1024
		dim i as long = 123
		dim pz as zstring ptr = @"hello"

		call_vsprintf_proc( @z, "%i %s %i", i, pz, clng( 456 ) )
		CU_ASSERT( z = "123 hello 456" )

	END_TEST

END_SUITE



