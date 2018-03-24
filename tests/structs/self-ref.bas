#include "fbcunit.bi"

SUITE( fbc_tests.structs.self_ref )

	'' C backend regression test
	type T
		as T ptr ptr ptr ppp
		as integer a
	end type

	TEST( all )
		dim as T x
		dim as T ptr p = @x
		dim as T ptr ptr pp = @p
		x.ppp = @pp
		x.a = 123

		CU_ASSERT( (**x.ppp)->a = 123 )
	END_TEST

END_SUITE
