#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_redim_presv )

	type foo
		field1 as string
		field2 as string
	end type

	#macro do_asserts( )
		CU_ASSERT_EQUAL( bar(0).field1, "i0_f1" )
		CU_ASSERT_EQUAL( bar(0).field2, "i0_f2" )
		CU_ASSERT_EQUAL( bar(1).field1, "i1_f1" )
		CU_ASSERT_EQUAL( bar(1).field2, "i1_f2" )
	#endmacro

	TEST( all )
		
		redim preserve as foo bar(0 to 3)
		
		with bar(0)
			.field1 = "i0_f1"
			.field2 = "i0_f2"
		end with

		with bar(1)
			.field1 = "i1_f1"
			.field2 = "i1_f2"
		end with
		
		do_asserts( )
		
		redim preserve as foo bar(0 to 2)
		do_asserts( )
		
		redim preserve as foo bar(0 to 1)
		do_asserts( )

		redim preserve as foo bar(0 to 3)
		do_asserts( )
		
	END_TEST
	
END_SUITE