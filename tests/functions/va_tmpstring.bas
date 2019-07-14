# include "fbcunit.bi"

#if (__FB_BACKEND__ = "gas")
	#define DOTEST
#endif

'' for other targets, see va_tmpstring-gcc.bas

#ifdef DOTEST

SUITE( fbc_tests.functions.va_tmpstring )

	dim shared strtb(1 to 2) as zstring * 6+1 => { "ABCdef", "defABC" }

	function toupperz( byval s as string ) as string
		return ucase( s )
	end function

	function tolowerz( byval s as string ) as string
		return lcase( s )
	end function

	function concatz( byval s1 as string, byval s2 as string ) as string
		return s1 + s2
	end function

	sub printstrings cdecl ( byval cnt as integer, ... )
		dim va as any ptr
		dim i as integer

		va = va_first( )

		for i = 1 to cnt
			CU_ASSERT( *va_arg( va, zstring ptr ) = strtb(i) )
			va = va_next( va, zstring ptr )
		next
	end sub

	TEST( tempStringArg )
		dim s as string
		dim z as zstring * 3+1

		s = "AbC"
		z = "dEf"

		printstrings 2, concatz( toupperz( s ), tolowerz( z ) ), concatz( tolowerz( z ), toupperz( s ) )
	END_TEST

END_SUITE

#endif
