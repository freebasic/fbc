#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_deref2 )

	type bar
		data as integer
	end type

	type foo
		b as bar
	end type

	operator -> ( byref lhs as foo ) as bar
		return lhs.b
	end operator

	TEST( all )
		dim as foo f = ( ( 1234 ) )
		
		CU_ASSERT_EQUAL( f->data, 1234 )
	END_TEST

END_SUITE
