#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.wz_conv )

	TEST( wstringToZstring )
		dim w as wstring * 50

		'' Store some Unicode text into w. This Russian text here happens to be
		'' the same for UTF16 (Windows wstring) and UTF32 (Linux wstring).
		w[ 0] = &h041D
		w[ 1] = &h043E
		w[ 2] = &h0432
		w[ 3] = &h0430
		w[ 4] = &h044F
		w[ 5] = &h0020
		w[ 6] = &h043F
		w[ 7] = &h0440
		w[ 8] = &h043E
		w[ 9] = &h0433
		w[10] = &h0440
		w[11] = &h0430
		w[12] = &h043C
		w[13] = &h043C
		w[14] = &h0430

		'' Convert to zstring
		dim s as string
		dim z as zstring * 50
		s = w
		z = w
		CU_ASSERT( len( s ) > 0 )
		CU_ASSERT( len( z ) > 0 )

		'' Ideally we could test the conversion results, but...
		''  - it depends on the system codepage at run-time. There are system
		''    functions to set that, but it's probably still not portable..
		''  - the conversion is lossy (especially when converting from Unicode
		''    to codepage and then back to Unicode)
		'CU_ASSERT( s = "..." )
		'CU_ASSERT( z = "..." )

		'' Convert back to wstring
		dim w_from_s as wstring * 50
		dim w_from_z as wstring * 50
		w_from_s = s
		w_from_z = z
		CU_ASSERT( len( w_from_s ) > 0 )
		CU_ASSERT( len( w_from_z ) > 0 )

		'' Ideally we'll get out what we started with, but that's not guaranteed...
		'CU_ASSERT( w_from_s = w )
		'CU_ASSERT( w_from_z = w )
	END_TEST

END_SUITE
