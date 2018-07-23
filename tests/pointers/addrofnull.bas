#include "fbcunit.bi"

SUITE( fbc_tests.pointers.addrofnull )

	TEST( addrOfNullTest )

		dim as integer ptr i1, i2, p
		dim as integer i

		i = 0
		i1 = @i
		i2 = i1
		
		CU_ASSERT_EQUAL( @p[*i1 + *i2], 0 )

	END_TEST

END_SUITE
