# include "fbcunit.bi"

SUITE( fbc_tests.functions.va_strings_gcc )

	dim shared strtb(1 to 8) as zstring * 4 => { "abc", "cde", "efg", "ghi", "ijk", "klm", "mno", "opq" }

	sub varstrings cdecl ( byval n as integer, ... )
		dim va as cva_list = any
		dim i as integer

		cva_start( va, n )

		for i = 1 to n
			CU_ASSERT( *cva_arg( va, zstring ptr ) = strtb(i) )
		next

		cva_end( va )
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
