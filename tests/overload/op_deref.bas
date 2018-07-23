#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_deref )

	type foo
		data as integer
	end type

	operator * ( byref lhs as foo ) as integer
		return lhs.data
	end operator

	operator -> ( byref lhs as foo ) as foo
		return lhs
	end operator

	TEST( all )
		dim as foo f = ( 1234 )
		
		CU_ASSERT_EQUAL( f->data, 1234 )
		CU_ASSERT_EQUAL( *f, 1234 )
	END_TEST

END_SUITE
