
'' test for implicit vars with same name as structs

#include "fbcunit.bi"

SUITE( fbc_tests.structs.imp_var_dup )

	type foo
		bar as integer
	end type

	TEST( all )
		dim as integer foo = 5678
		
		dim f as foo = ( 1234 )

		CU_ASSERT_EQUAL( f.bar, 1234 )
		CU_ASSERT_EQUAL( foo, 5678 )
	END_TEST
		
END_SUITE
