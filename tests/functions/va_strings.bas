# include "fbcunit.bi"

#if (__FB_BACKEND__ = "gas")
	#define DOTEST
#endif

'' for other targets, see var_strings-gcc.bas

#ifdef DOTEST

SUITE( fbc_tests.functions.va_strings )

	dim shared strtb(1 to 8) as zstring * 4 => { "abc", "cde", "efg", "ghi", "ijk", "klm", "mno", "opq" }

	sub varstrings cdecl ( byval n as integer, ... )
		dim va as any ptr
		dim i as integer

		va = va_first( )

		for i = 1 to n
			CU_ASSERT( *va_arg( va, zstring ptr ) = strtb(i) )
			va = va_next( va, zstring ptr )
		next
	end sub

	sub vastrings_test( byval a as string )
		dim s as string
		dim f as string * 3
		dim z as zstring * 3+1
		dim p1 as zstring ptr, p2 as zstring ptr

		s = strtb(3)
		f = strtb(4)
		z = strtb(5)
		p1 = strptr( strtb(7) )
		p2 = strptr( strtb(8) )
		varstrings 8, "abc", "cde", s, f, z, a, p1, *p2
	end sub

	TEST( varArgStrings )
		vastrings_test strtb(6)
	END_TEST

END_SUITE

#endif
