#include "fbcunit.bi"

SUITE( fbc_tests.expressions.memberderef )

	TEST_GROUP( syntax )
		type UDT
			i as integer
		end type

		dim shared x as UDT = (123)
		dim shared p as UDT ptr = @x
		dim shared pp as UDT ptr ptr = @p

		TEST( default )
			CU_ASSERT( p->i = 123 )
			CU_ASSERT( (*p).i = 123 )
			CU_ASSERT( p[0].i = 123 )

			CU_ASSERT( (*pp)->i = 123 )
			CU_ASSERT( pp[0]->i = 123 )
			CU_ASSERT( (*pp[0]).i = 123 )
			CU_ASSERT( (**pp).i = 123 )
			CU_ASSERT( (*pp)[0].i = 123 )
		END_TEST
	END_TEST_GROUP

END_SUITE
