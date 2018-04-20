#include "fbcunit.bi"

SUITE( fbc_tests.overload_.hex_oct_bin )

	TEST( nonConst )
		type T
			as integer a, b, c, d
		end type

		dim b as byte = -2 ^ 7
		dim s as short = -2 ^ 15
		dim l as long = -2 ^ 31
		dim ll as longint = -2LL ^ 63
	#ifdef __FB_64BIT__
		dim i as integer = ll
	#else
		dim i as integer = l
	#endif
		dim p as any ptr = cptr( any ptr, i )
		dim pt as T ptr = cptr( T ptr, p )

		dim pconst as const any ptr = cptr( const any ptr, i )
		dim pconstt as const T ptr = cptr( const T ptr, pconst )

		#include "hex_oct_bin_checks.bi"
	END_TEST

	TEST( const_ )
		type T
			as integer a, b, c, d
		end type

		dim b as const byte = -2 ^ 7
		dim s as const short = -2 ^ 15
		dim l as const long = -2 ^ 31
		dim ll as const longint = -2LL ^ 63
	#ifdef __FB_64BIT__
		dim i as const integer = ll
	#else
		dim i as const integer = l
	#endif
		dim p as any const ptr = cptr( any ptr, i )
		dim pt as T const ptr = cptr( T ptr, p )

		dim pconst as const any const ptr = cptr( const any ptr, i )
		dim pconstt as const T const ptr = cptr( const T ptr, pconst )

		#include "hex_oct_bin_checks.bi"
	END_TEST

END_SUITE
