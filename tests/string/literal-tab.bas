#include "fbcunit.bi"

SUITE( fbc_tests.string_.literal_tab )

	TEST( default)

		'' test that literal tabs in the source file
		'' are correctly escaped and emitted.

		'' careful - string is 'x' chr(9) '0' 'x' chr(9) '0' '9'
		dim as string a = "x	0x	1x"
		dim as string b = "x" & chr(9) & "0x" & chr(9) & "1x"
		dim as string c = !"x\t0x\t1x"
		dim as ubyte d(0 to 6) = { asc("x"), 9, asc("0"), asc("x"), _
			9, asc("1"), asc("x") }

		CU_ASSERT( len("x	0x	1x") = 7 )
		CU_ASSERT( len( a ) = 7 )
		CU_ASSERT( len( b ) = 7 )
		CU_ASSERT( len( c ) = 7 )

		CU_ASSERT( a = "x	0x	1x" )
		CU_ASSERT( b = a )
		CU_ASSERT( c = a )

		for i as integer = 0 to 6
			CU_ASSERT( a[i] = d(i) )
			CU_ASSERT( b[i] = d(i) )
			CU_ASSERT( c[i] = d(i) )
		next

	END_TEST

END_SUITE
