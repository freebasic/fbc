#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_union_copy )

	const TEST_F0 = 1234
	const TEST_F4 = 12345.6
	const TEST_F6 = 5678

	type bar
		unused as string
	end type

	type foo
		f0 as integer
		union
    		f1 as byte
    		f2 as short
    		f3 as integer
    		f4 as double
    		f5 as longint
		end union
		f6 as integer
    
		fctor as bar
	end type

	TEST( all )
		dim fl as foo, fr as foo
		
		fl.f0 = TEST_F0
		fl.f4 = TEST_F4
		fl.f6 = TEST_F6
		
		fr = fl
		
		CU_ASSERT_EQUAL( fr.f0, TEST_F0 )
		CU_ASSERT_EQUAL( fr.f4, TEST_F4 )
		CU_ASSERT_EQUAL( fr.f6, TEST_F6 )
		
	END_TEST
	
END_SUITE
