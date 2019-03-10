# include "fbcunit.bi"

SUITE( fbc_tests.functions.va_int_and_ptrs_gcc )

	sub varints cdecl ( byval n as integer, ... )
		dim va as cva_list = any
		dim i as integer

		cva_start( va, n )

		for i = 1 to n
			CU_ASSERT( cva_arg( va, integer ) = i )
		next

		cva_end( va )
	end sub

	sub varintptrs cdecl ( byval n as integer, ... )
		dim va as cva_list = any
		dim i as integer

		cva_start( va, n )

		for i = 1 to n
			CU_ASSERT( *cva_arg( va, integer ptr ) )
		next

		cva_end( va )
	end sub

	sub vaints_test( d as integer )
		dim as integer a, b, c
		dim as integer ptr pa, pb, pc
		dim as integer ptr ptr ppc
		a = 1
		b = 2
		c = 3

		pa = @a
		pb = @b
		pc = @c
		ppc = @pc

		varints 4, a, *pb, **ppc, d
		varintptrs 4, pa, pb, pc, @d
	end sub

	TEST( varIntegerArgs )
		vaints_test 4
	END_TEST

END_SUITE
