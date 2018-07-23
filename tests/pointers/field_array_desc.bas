#include "fbcunit.bi"

SUITE( fbc_tests.pointers.field_array_desc )

	type foo
	  bar(0 To 2) as integer
	end type

	TEST( derefArray )

		dim f as foo
		dim pf as foo ptr = @f

  		CU_ASSERT_EQUAL( lbound(pf->bar), 0 )
  		CU_ASSERT_EQUAL( ubound(pf->bar), 2 )

	END_TEST

END_SUITE
