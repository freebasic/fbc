# include "fbcu.bi"

namespace fbc_tests.overloads.hex_oct_bin

sub testNonConst cdecl( )
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
end sub

sub testConst cdecl( )
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
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.overload.hex_oct_bin" )
	fbcu.add_test( "non-const", @testNonConst )
	fbcu.add_test( "const", @testConst )
end sub

end namespace
