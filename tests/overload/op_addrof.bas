#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_addrof )

	type foo
		declare operator @ () as integer ptr
		data as integer
	end type

	operator foo.@ () as integer ptr
		return @data
	end operator

	TEST( all )
		dim as foo f = ( -1234 )
		
		CU_ASSERT_EQUAL( *@f, -1234 )
	END_TEST

END_SUITE
