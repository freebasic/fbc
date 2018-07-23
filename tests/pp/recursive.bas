#include "fbcunit.bi"

#define foo1(p) #p
#define foo2(p) p##p
#define foo3(p) foo1(foo2 p)
#define foo4(p) foo1(foo2(p))

SUITE( fbc_tests.pp.recursive )

	TEST( recursive_ )

		CU_ASSERT_EQUAL( foo1(foo2(bar)), foo3((bar)) )
		CU_ASSERT_EQUAL( foo1(foo2(bar)), foo4(bar) )

	END_TEST

END_SUITE
