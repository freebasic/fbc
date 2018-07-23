#include "fbcunit.bi"

SUITE( fbc_tests.dim_.extern_init )

	'' Should compile fine under -gen gcc
	extern p1 as integer ptr
	dim shared x1 as integer
	dim shared p1 as integer ptr = @x1

	extern p2 as integer ptr
	dim shared x2 as integer = 1
	dim shared p2 as integer ptr = @x2

	TEST( testproc )
		CU_ASSERT( p1 = @x1 )
		CU_ASSERT( x1 = 0 )

		CU_ASSERT( p2 = @x2 )
		CU_ASSERT( x2 = 1 )
	END_TEST

END_SUITE
